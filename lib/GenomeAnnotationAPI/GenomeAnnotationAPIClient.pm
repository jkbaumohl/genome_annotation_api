package GenomeAnnotationAPI::GenomeAnnotationAPIClient;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

GenomeAnnotationAPI::GenomeAnnotationAPIClient

=head1 DESCRIPTION


A KBase module: GenomeAnnotationAPI


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => GenomeAnnotationAPI::GenomeAnnotationAPIClient::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my $token = Bio::KBase::AuthToken->new(@args);
	
	if (!$token->error_message)
	{
	    $self->{token} = $token->token;
	    $self->{client}->{token} = $token->token;
	}
        else
        {
	    #
	    # All methods in this module require authentication. In this case, if we
	    # don't have a token, we can't continue.
	    #
	    die "Authentication failed: " . $token->error_message;
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 get_taxon

  $return = $obj->get_taxon($inputs_get_taxon)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_taxon is a GenomeAnnotationAPI.inputs_get_taxon
$return is a GenomeAnnotationAPI.ObjectReference
inputs_get_taxon is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_taxon is a GenomeAnnotationAPI.inputs_get_taxon
$return is a GenomeAnnotationAPI.ObjectReference
inputs_get_taxon is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_taxon
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_taxon (received $n, expecting 1)");
    }
    {
	my($inputs_get_taxon) = @args;

	my @_bad_arguments;
        (ref($inputs_get_taxon) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_taxon\" (value was \"$inputs_get_taxon\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_taxon:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_taxon');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_taxon",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_taxon',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_taxon",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_taxon',
				       );
    }
}
 


=head2 get_assembly

  $return = $obj->get_assembly($inputs_get_assembly)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_assembly is a GenomeAnnotationAPI.inputs_get_assembly
$return is a GenomeAnnotationAPI.ObjectReference
inputs_get_assembly is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_assembly is a GenomeAnnotationAPI.inputs_get_assembly
$return is a GenomeAnnotationAPI.ObjectReference
inputs_get_assembly is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_assembly
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_assembly (received $n, expecting 1)");
    }
    {
	my($inputs_get_assembly) = @args;

	my @_bad_arguments;
        (ref($inputs_get_assembly) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_assembly\" (value was \"$inputs_get_assembly\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_assembly:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_assembly');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_assembly",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_assembly',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_assembly",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_assembly',
				       );
    }
}
 


=head2 get_feature_types

  $return = $obj->get_feature_types($inputs_get_feature_types)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_types is a GenomeAnnotationAPI.inputs_get_feature_types
$return is a reference to a list where each element is a string
inputs_get_feature_types is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_feature_types is a GenomeAnnotationAPI.inputs_get_feature_types
$return is a reference to a list where each element is a string
inputs_get_feature_types is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_feature_types
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_types (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_types) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_types) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_types\" (value was \"$inputs_get_feature_types\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_types:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_types');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_types",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_types',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_types",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_types',
				       );
    }
}
 


=head2 get_feature_type_descriptions

  $return = $obj->get_feature_type_descriptions($inputs_get_feature_type_descriptions)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_type_descriptions is a GenomeAnnotationAPI.inputs_get_feature_type_descriptions
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_feature_type_descriptions is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_type_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_feature_type_descriptions is a GenomeAnnotationAPI.inputs_get_feature_type_descriptions
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_feature_type_descriptions is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_type_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_feature_type_descriptions
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_type_descriptions (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_type_descriptions) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_type_descriptions) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_type_descriptions\" (value was \"$inputs_get_feature_type_descriptions\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_type_descriptions:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_type_descriptions');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_type_descriptions",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_type_descriptions',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_type_descriptions",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_type_descriptions',
				       );
    }
}
 


=head2 get_feature_type_counts

  $return = $obj->get_feature_type_counts($inputs_get_feature_type_counts)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_type_counts is a GenomeAnnotationAPI.inputs_get_feature_type_counts
$return is a reference to a hash where the key is a string and the value is an int
inputs_get_feature_type_counts is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_type_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_feature_type_counts is a GenomeAnnotationAPI.inputs_get_feature_type_counts
$return is a reference to a hash where the key is a string and the value is an int
inputs_get_feature_type_counts is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_type_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_feature_type_counts
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_type_counts (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_type_counts) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_type_counts) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_type_counts\" (value was \"$inputs_get_feature_type_counts\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_type_counts:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_type_counts');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_type_counts",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_type_counts',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_type_counts",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_type_counts',
				       );
    }
}
 


=head2 get_feature_ids

  $return = $obj->get_feature_ids($inputs_get_feature_ids)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_ids is a GenomeAnnotationAPI.inputs_get_feature_ids
$return is a GenomeAnnotationAPI.Feature_id_mapping
inputs_get_feature_ids is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	filters has a value which is a GenomeAnnotationAPI.Feature_id_filters
	group_by has a value which is a string
ObjectReference is a string
Feature_id_filters is a reference to a hash where the following keys are defined:
	type_list has a value which is a reference to a list where each element is a string
	region_list has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	function_list has a value which is a reference to a list where each element is a string
	alias_list has a value which is a reference to a list where each element is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int
Feature_id_mapping is a reference to a hash where the following keys are defined:
	by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string

</pre>

=end html

=begin text

$inputs_get_feature_ids is a GenomeAnnotationAPI.inputs_get_feature_ids
$return is a GenomeAnnotationAPI.Feature_id_mapping
inputs_get_feature_ids is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	filters has a value which is a GenomeAnnotationAPI.Feature_id_filters
	group_by has a value which is a string
ObjectReference is a string
Feature_id_filters is a reference to a hash where the following keys are defined:
	type_list has a value which is a reference to a list where each element is a string
	region_list has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	function_list has a value which is a reference to a list where each element is a string
	alias_list has a value which is a reference to a list where each element is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int
Feature_id_mapping is a reference to a hash where the following keys are defined:
	by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string


=end text

=item Description



=back

=cut

 sub get_feature_ids
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_ids (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_ids) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_ids) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_ids\" (value was \"$inputs_get_feature_ids\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_ids:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_ids');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_ids",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_ids',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_ids",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_ids',
				       );
    }
}
 


=head2 get_features

  $return = $obj->get_features($inputs_get_features)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_features is a GenomeAnnotationAPI.inputs_get_features
$return is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.Feature_data
inputs_get_features is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
	exclude_sequence has a value which is a GenomeAnnotationAPI.boolean
ObjectReference is a string
boolean is an int
Feature_data is a reference to a hash where the following keys are defined:
	feature_id has a value which is a string
	feature_type has a value which is a string
	feature_function has a value which is a string
	feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	feature_dna_sequence_length has a value which is an int
	feature_dna_sequence has a value which is a string
	feature_md5 has a value which is a string
	feature_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	feature_publications has a value which is a reference to a list where each element is a string
	feature_quality_warnings has a value which is a reference to a list where each element is a string
	feature_quality_score has a value which is a reference to a list where each element is a string
	feature_notes has a value which is a string
	feature_inference has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int

</pre>

=end html

=begin text

$inputs_get_features is a GenomeAnnotationAPI.inputs_get_features
$return is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.Feature_data
inputs_get_features is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
	exclude_sequence has a value which is a GenomeAnnotationAPI.boolean
ObjectReference is a string
boolean is an int
Feature_data is a reference to a hash where the following keys are defined:
	feature_id has a value which is a string
	feature_type has a value which is a string
	feature_function has a value which is a string
	feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	feature_dna_sequence_length has a value which is an int
	feature_dna_sequence has a value which is a string
	feature_md5 has a value which is a string
	feature_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	feature_publications has a value which is a reference to a list where each element is a string
	feature_quality_warnings has a value which is a reference to a list where each element is a string
	feature_quality_score has a value which is a reference to a list where each element is a string
	feature_notes has a value which is a string
	feature_inference has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int


=end text

=item Description



=back

=cut

 sub get_features
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_features (received $n, expecting 1)");
    }
    {
	my($inputs_get_features) = @args;

	my @_bad_arguments;
        (ref($inputs_get_features) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_features\" (value was \"$inputs_get_features\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_features:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_features');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_features",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_features',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_features",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_features',
				       );
    }
}
 


=head2 get_features2

  $return = $obj->get_features2($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a GenomeAnnotationAPI.GetFeatures2Params
$return is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.Feature_data
GetFeatures2Params is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
	exclude_sequence has a value which is a GenomeAnnotationAPI.boolean
ObjectReference is a string
boolean is an int
Feature_data is a reference to a hash where the following keys are defined:
	feature_id has a value which is a string
	feature_type has a value which is a string
	feature_function has a value which is a string
	feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	feature_dna_sequence_length has a value which is an int
	feature_dna_sequence has a value which is a string
	feature_md5 has a value which is a string
	feature_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	feature_publications has a value which is a reference to a list where each element is a string
	feature_quality_warnings has a value which is a reference to a list where each element is a string
	feature_quality_score has a value which is a reference to a list where each element is a string
	feature_notes has a value which is a string
	feature_inference has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int

</pre>

=end html

=begin text

$params is a GenomeAnnotationAPI.GetFeatures2Params
$return is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.Feature_data
GetFeatures2Params is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
	exclude_sequence has a value which is a GenomeAnnotationAPI.boolean
ObjectReference is a string
boolean is an int
Feature_data is a reference to a hash where the following keys are defined:
	feature_id has a value which is a string
	feature_type has a value which is a string
	feature_function has a value which is a string
	feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	feature_dna_sequence_length has a value which is an int
	feature_dna_sequence has a value which is a string
	feature_md5 has a value which is a string
	feature_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	feature_publications has a value which is a reference to a list where each element is a string
	feature_quality_warnings has a value which is a reference to a list where each element is a string
	feature_quality_score has a value which is a reference to a list where each element is a string
	feature_notes has a value which is a string
	feature_inference has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int


=end text

=item Description

Retrieve Feature data, v2.

@param feature_id_list List of Features to retrieve.
  If None, returns all Feature data.
@return Mapping from Feature IDs to dicts of available data.

=back

=cut

 sub get_features2
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_features2 (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_features2:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_features2');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_features2",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_features2',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_features2",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_features2',
				       );
    }
}
 


=head2 get_proteins

  $return = $obj->get_proteins($inputs_get_proteins)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_proteins is a GenomeAnnotationAPI.inputs_get_proteins
$return is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.Protein_data
inputs_get_proteins is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string
Protein_data is a reference to a hash where the following keys are defined:
	protein_id has a value which is a string
	protein_amino_acid_sequence has a value which is a string
	protein_function has a value which is a string
	protein_aliases has a value which is a reference to a list where each element is a string
	protein_md5 has a value which is a string
	protein_domain_locations has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

$inputs_get_proteins is a GenomeAnnotationAPI.inputs_get_proteins
$return is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.Protein_data
inputs_get_proteins is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string
Protein_data is a reference to a hash where the following keys are defined:
	protein_id has a value which is a string
	protein_amino_acid_sequence has a value which is a string
	protein_function has a value which is a string
	protein_aliases has a value which is a reference to a list where each element is a string
	protein_md5 has a value which is a string
	protein_domain_locations has a value which is a reference to a list where each element is a string


=end text

=item Description



=back

=cut

 sub get_proteins
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_proteins (received $n, expecting 1)");
    }
    {
	my($inputs_get_proteins) = @args;

	my @_bad_arguments;
        (ref($inputs_get_proteins) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_proteins\" (value was \"$inputs_get_proteins\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_proteins:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_proteins');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_proteins",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_proteins',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_proteins",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_proteins',
				       );
    }
}
 


=head2 get_feature_locations

  $return = $obj->get_feature_locations($inputs_get_feature_locations)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_locations is a GenomeAnnotationAPI.inputs_get_feature_locations
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a GenomeAnnotationAPI.Region
inputs_get_feature_locations is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int

</pre>

=end html

=begin text

$inputs_get_feature_locations is a GenomeAnnotationAPI.inputs_get_feature_locations
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a GenomeAnnotationAPI.Region
inputs_get_feature_locations is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int


=end text

=item Description



=back

=cut

 sub get_feature_locations
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_locations (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_locations) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_locations) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_locations\" (value was \"$inputs_get_feature_locations\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_locations:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_locations');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_locations",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_locations',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_locations",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_locations',
				       );
    }
}
 


=head2 get_feature_publications

  $return = $obj->get_feature_publications($inputs_get_feature_publications)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_publications is a GenomeAnnotationAPI.inputs_get_feature_publications
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_feature_publications is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_feature_publications is a GenomeAnnotationAPI.inputs_get_feature_publications
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_feature_publications is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_feature_publications
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_publications (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_publications) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_publications) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_publications\" (value was \"$inputs_get_feature_publications\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_publications:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_publications');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_publications",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_publications',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_publications",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_publications',
				       );
    }
}
 


=head2 get_feature_dna

  $return = $obj->get_feature_dna($inputs_get_feature_dna)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_dna is a GenomeAnnotationAPI.inputs_get_feature_dna
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_feature_dna is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_feature_dna is a GenomeAnnotationAPI.inputs_get_feature_dna
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_feature_dna is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_feature_dna
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_dna (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_dna) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_dna) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_dna\" (value was \"$inputs_get_feature_dna\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_dna:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_dna');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_dna",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_dna',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_dna",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_dna',
				       );
    }
}
 


=head2 get_feature_functions

  $return = $obj->get_feature_functions($inputs_get_feature_functions)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_functions is a GenomeAnnotationAPI.inputs_get_feature_functions
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_feature_functions is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_feature_functions is a GenomeAnnotationAPI.inputs_get_feature_functions
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_feature_functions is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_feature_functions
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_functions (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_functions) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_functions) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_functions\" (value was \"$inputs_get_feature_functions\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_functions:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_functions');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_functions",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_functions',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_functions",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_functions',
				       );
    }
}
 


=head2 get_feature_aliases

  $return = $obj->get_feature_aliases($inputs_get_feature_aliases)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_feature_aliases is a GenomeAnnotationAPI.inputs_get_feature_aliases
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_feature_aliases is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_feature_aliases is a GenomeAnnotationAPI.inputs_get_feature_aliases
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_feature_aliases is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	feature_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_feature_aliases
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_aliases (received $n, expecting 1)");
    }
    {
	my($inputs_get_feature_aliases) = @args;

	my @_bad_arguments;
        (ref($inputs_get_feature_aliases) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_feature_aliases\" (value was \"$inputs_get_feature_aliases\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_aliases:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_aliases');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_feature_aliases",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_aliases',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_aliases",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_aliases',
				       );
    }
}
 


=head2 get_cds_by_gene

  $return = $obj->get_cds_by_gene($inputs_get_cds_by_gene)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_cds_by_gene is a GenomeAnnotationAPI.inputs_get_cds_by_gene
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_cds_by_gene is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	gene_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_cds_by_gene is a GenomeAnnotationAPI.inputs_get_cds_by_gene
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_cds_by_gene is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	gene_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_cds_by_gene
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_cds_by_gene (received $n, expecting 1)");
    }
    {
	my($inputs_get_cds_by_gene) = @args;

	my @_bad_arguments;
        (ref($inputs_get_cds_by_gene) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_cds_by_gene\" (value was \"$inputs_get_cds_by_gene\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_cds_by_gene:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_cds_by_gene');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_cds_by_gene",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_cds_by_gene',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_cds_by_gene",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_cds_by_gene',
				       );
    }
}
 


=head2 get_cds_by_mrna

  $return = $obj->get_cds_by_mrna($inputs_mrna_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_mrna_id_list is a GenomeAnnotationAPI.inputs_mrna_id_list
$return is a reference to a hash where the key is a string and the value is a string
inputs_mrna_id_list is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_mrna_id_list is a GenomeAnnotationAPI.inputs_mrna_id_list
$return is a reference to a hash where the key is a string and the value is a string
inputs_mrna_id_list is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_cds_by_mrna
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_cds_by_mrna (received $n, expecting 1)");
    }
    {
	my($inputs_mrna_id_list) = @args;

	my @_bad_arguments;
        (ref($inputs_mrna_id_list) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_mrna_id_list\" (value was \"$inputs_mrna_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_cds_by_mrna:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_cds_by_mrna');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_cds_by_mrna",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_cds_by_mrna',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_cds_by_mrna",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_cds_by_mrna',
				       );
    }
}
 


=head2 get_gene_by_cds

  $return = $obj->get_gene_by_cds($inputs_get_gene_by_cds)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_gene_by_cds is a GenomeAnnotationAPI.inputs_get_gene_by_cds
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_gene_by_cds is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	cds_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_gene_by_cds is a GenomeAnnotationAPI.inputs_get_gene_by_cds
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_gene_by_cds is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	cds_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_gene_by_cds
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_gene_by_cds (received $n, expecting 1)");
    }
    {
	my($inputs_get_gene_by_cds) = @args;

	my @_bad_arguments;
        (ref($inputs_get_gene_by_cds) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_gene_by_cds\" (value was \"$inputs_get_gene_by_cds\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_gene_by_cds:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_gene_by_cds');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_gene_by_cds",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_gene_by_cds',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_gene_by_cds",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_gene_by_cds',
				       );
    }
}
 


=head2 get_gene_by_mrna

  $return = $obj->get_gene_by_mrna($inputs_get_gene_by_mrna)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_gene_by_mrna is a GenomeAnnotationAPI.inputs_get_gene_by_mrna
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_gene_by_mrna is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_gene_by_mrna is a GenomeAnnotationAPI.inputs_get_gene_by_mrna
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_gene_by_mrna is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_gene_by_mrna
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_gene_by_mrna (received $n, expecting 1)");
    }
    {
	my($inputs_get_gene_by_mrna) = @args;

	my @_bad_arguments;
        (ref($inputs_get_gene_by_mrna) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_gene_by_mrna\" (value was \"$inputs_get_gene_by_mrna\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_gene_by_mrna:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_gene_by_mrna');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_gene_by_mrna",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_gene_by_mrna',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_gene_by_mrna",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_gene_by_mrna',
				       );
    }
}
 


=head2 get_mrna_by_cds

  $return = $obj->get_mrna_by_cds($inputs_get_mrna_by_cds)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_mrna_by_cds is a GenomeAnnotationAPI.inputs_get_mrna_by_cds
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_mrna_by_cds is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	cds_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_mrna_by_cds is a GenomeAnnotationAPI.inputs_get_mrna_by_cds
$return is a reference to a hash where the key is a string and the value is a string
inputs_get_mrna_by_cds is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	cds_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_mrna_by_cds
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_mrna_by_cds (received $n, expecting 1)");
    }
    {
	my($inputs_get_mrna_by_cds) = @args;

	my @_bad_arguments;
        (ref($inputs_get_mrna_by_cds) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_mrna_by_cds\" (value was \"$inputs_get_mrna_by_cds\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_mrna_by_cds:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_mrna_by_cds');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_mrna_by_cds",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_mrna_by_cds',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_mrna_by_cds",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_mrna_by_cds',
				       );
    }
}
 


=head2 get_mrna_by_gene

  $return = $obj->get_mrna_by_gene($inputs_get_mrna_by_gene)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_mrna_by_gene is a GenomeAnnotationAPI.inputs_get_mrna_by_gene
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_mrna_by_gene is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	gene_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$inputs_get_mrna_by_gene is a GenomeAnnotationAPI.inputs_get_mrna_by_gene
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
inputs_get_mrna_by_gene is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	gene_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description



=back

=cut

 sub get_mrna_by_gene
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_mrna_by_gene (received $n, expecting 1)");
    }
    {
	my($inputs_get_mrna_by_gene) = @args;

	my @_bad_arguments;
        (ref($inputs_get_mrna_by_gene) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_mrna_by_gene\" (value was \"$inputs_get_mrna_by_gene\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_mrna_by_gene:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_mrna_by_gene');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_mrna_by_gene",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_mrna_by_gene',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_mrna_by_gene",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_mrna_by_gene',
				       );
    }
}
 


=head2 get_mrna_exons

  $return = $obj->get_mrna_exons($inputs_get_mrna_exons)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_mrna_exons is a GenomeAnnotationAPI.inputs_get_mrna_exons
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a GenomeAnnotationAPI.Exon_data
inputs_get_mrna_exons is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string
Exon_data is a reference to a hash where the following keys are defined:
	exon_location has a value which is a GenomeAnnotationAPI.Region
	exon_dna_sequence has a value which is a string
	exon_ordinal has a value which is an int
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int

</pre>

=end html

=begin text

$inputs_get_mrna_exons is a GenomeAnnotationAPI.inputs_get_mrna_exons
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a GenomeAnnotationAPI.Exon_data
inputs_get_mrna_exons is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string
Exon_data is a reference to a hash where the following keys are defined:
	exon_location has a value which is a GenomeAnnotationAPI.Region
	exon_dna_sequence has a value which is a string
	exon_ordinal has a value which is an int
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int


=end text

=item Description



=back

=cut

 sub get_mrna_exons
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_mrna_exons (received $n, expecting 1)");
    }
    {
	my($inputs_get_mrna_exons) = @args;

	my @_bad_arguments;
        (ref($inputs_get_mrna_exons) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_mrna_exons\" (value was \"$inputs_get_mrna_exons\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_mrna_exons:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_mrna_exons');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_mrna_exons",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_mrna_exons',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_mrna_exons",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_mrna_exons',
				       );
    }
}
 


=head2 get_mrna_utrs

  $return = $obj->get_mrna_utrs($inputs_get_mrna_utrs)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_mrna_utrs is a GenomeAnnotationAPI.inputs_get_mrna_utrs
$return is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.UTR_data
inputs_get_mrna_utrs is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string
UTR_data is a reference to a hash where the following keys are defined:
	utr_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	utr_dna_sequence has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int

</pre>

=end html

=begin text

$inputs_get_mrna_utrs is a GenomeAnnotationAPI.inputs_get_mrna_utrs
$return is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a GenomeAnnotationAPI.UTR_data
inputs_get_mrna_utrs is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
	mrna_id_list has a value which is a reference to a list where each element is a string
ObjectReference is a string
UTR_data is a reference to a hash where the following keys are defined:
	utr_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
	utr_dna_sequence has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int


=end text

=item Description



=back

=cut

 sub get_mrna_utrs
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_mrna_utrs (received $n, expecting 1)");
    }
    {
	my($inputs_get_mrna_utrs) = @args;

	my @_bad_arguments;
        (ref($inputs_get_mrna_utrs) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_mrna_utrs\" (value was \"$inputs_get_mrna_utrs\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_mrna_utrs:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_mrna_utrs');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_mrna_utrs",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_mrna_utrs',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_mrna_utrs",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_mrna_utrs',
				       );
    }
}
 


=head2 get_summary

  $return = $obj->get_summary($inputs_get_summary)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_get_summary is a GenomeAnnotationAPI.inputs_get_summary
$return is a GenomeAnnotationAPI.Summary_data
inputs_get_summary is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string
Summary_data is a reference to a hash where the following keys are defined:
	scientific_name has a value which is a string
	taxonomy_id has a value which is an int
	kingdom has a value which is a string
	scientific_lineage has a value which is a reference to a list where each element is a string
	genetic_code has a value which is an int
	organism_aliases has a value which is a reference to a list where each element is a string
	assembly_source has a value which is a string
	assembly_source_id has a value which is a string
	assembly_source_date has a value which is a string
	gc_content has a value which is a float
	dna_size has a value which is an int
	num_contigs has a value which is an int
	contig_ids has a value which is a reference to a list where each element is a string
	external_source has a value which is a string
	external_source_date has a value which is a string
	release has a value which is a string
	original_source_filename has a value which is a string
	feature_type_counts has a value which is a reference to a hash where the key is a string and the value is an int

</pre>

=end html

=begin text

$inputs_get_summary is a GenomeAnnotationAPI.inputs_get_summary
$return is a GenomeAnnotationAPI.Summary_data
inputs_get_summary is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string
Summary_data is a reference to a hash where the following keys are defined:
	scientific_name has a value which is a string
	taxonomy_id has a value which is an int
	kingdom has a value which is a string
	scientific_lineage has a value which is a reference to a list where each element is a string
	genetic_code has a value which is an int
	organism_aliases has a value which is a reference to a list where each element is a string
	assembly_source has a value which is a string
	assembly_source_id has a value which is a string
	assembly_source_date has a value which is a string
	gc_content has a value which is a float
	dna_size has a value which is an int
	num_contigs has a value which is an int
	contig_ids has a value which is a reference to a list where each element is a string
	external_source has a value which is a string
	external_source_date has a value which is a string
	release has a value which is a string
	original_source_filename has a value which is a string
	feature_type_counts has a value which is a reference to a hash where the key is a string and the value is an int


=end text

=item Description



=back

=cut

 sub get_summary
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_summary (received $n, expecting 1)");
    }
    {
	my($inputs_get_summary) = @args;

	my @_bad_arguments;
        (ref($inputs_get_summary) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_get_summary\" (value was \"$inputs_get_summary\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_summary:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_summary');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.get_summary",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_summary',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_summary",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_summary',
				       );
    }
}
 


=head2 save_summary

  $return_1, $return_2 = $obj->save_summary($inputs_save_summary)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs_save_summary is a GenomeAnnotationAPI.inputs_save_summary
$return_1 is an int
$return_2 is a GenomeAnnotationAPI.Summary_data
inputs_save_summary is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string
Summary_data is a reference to a hash where the following keys are defined:
	scientific_name has a value which is a string
	taxonomy_id has a value which is an int
	kingdom has a value which is a string
	scientific_lineage has a value which is a reference to a list where each element is a string
	genetic_code has a value which is an int
	organism_aliases has a value which is a reference to a list where each element is a string
	assembly_source has a value which is a string
	assembly_source_id has a value which is a string
	assembly_source_date has a value which is a string
	gc_content has a value which is a float
	dna_size has a value which is an int
	num_contigs has a value which is an int
	contig_ids has a value which is a reference to a list where each element is a string
	external_source has a value which is a string
	external_source_date has a value which is a string
	release has a value which is a string
	original_source_filename has a value which is a string
	feature_type_counts has a value which is a reference to a hash where the key is a string and the value is an int

</pre>

=end html

=begin text

$inputs_save_summary is a GenomeAnnotationAPI.inputs_save_summary
$return_1 is an int
$return_2 is a GenomeAnnotationAPI.Summary_data
inputs_save_summary is a reference to a hash where the following keys are defined:
	ref has a value which is a GenomeAnnotationAPI.ObjectReference
ObjectReference is a string
Summary_data is a reference to a hash where the following keys are defined:
	scientific_name has a value which is a string
	taxonomy_id has a value which is an int
	kingdom has a value which is a string
	scientific_lineage has a value which is a reference to a list where each element is a string
	genetic_code has a value which is an int
	organism_aliases has a value which is a reference to a list where each element is a string
	assembly_source has a value which is a string
	assembly_source_id has a value which is a string
	assembly_source_date has a value which is a string
	gc_content has a value which is a float
	dna_size has a value which is an int
	num_contigs has a value which is an int
	contig_ids has a value which is a reference to a list where each element is a string
	external_source has a value which is a string
	external_source_date has a value which is a string
	release has a value which is a string
	original_source_filename has a value which is a string
	feature_type_counts has a value which is a reference to a hash where the key is a string and the value is an int


=end text

=item Description



=back

=cut

 sub save_summary
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function save_summary (received $n, expecting 1)");
    }
    {
	my($inputs_save_summary) = @args;

	my @_bad_arguments;
        (ref($inputs_save_summary) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"inputs_save_summary\" (value was \"$inputs_save_summary\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to save_summary:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'save_summary');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "GenomeAnnotationAPI.save_summary",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'save_summary',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method save_summary",
					    status_line => $self->{client}->status_line,
					    method_name => 'save_summary',
				       );
    }
}
 
  

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "GenomeAnnotationAPI.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'save_summary',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method save_summary",
            status_line => $self->{client}->status_line,
            method_name => 'save_summary',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for GenomeAnnotationAPI::GenomeAnnotationAPIClient\n";
    }
    if ($sMajor == 0) {
        warn "GenomeAnnotationAPI::GenomeAnnotationAPIClient version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 ObjectReference

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 boolean

=over 4



=item Description

A boolean - 0 for false, 1 for true.
@range (0, 1)


=item Definition

=begin html

<pre>
an int
</pre>

=end html

=begin text

an int

=end text

=back



=head2 Region

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
contig_id has a value which is a string
strand has a value which is a string
start has a value which is an int
length has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
contig_id has a value which is a string
strand has a value which is a string
start has a value which is an int
length has a value which is an int


=end text

=back



=head2 Feature_id_filters

=over 4



=item Description

*
* Filters passed to :meth:`get_feature_ids`
* @optional type_list region_list function_list alias_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
type_list has a value which is a reference to a list where each element is a string
region_list has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
function_list has a value which is a reference to a list where each element is a string
alias_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
type_list has a value which is a reference to a list where each element is a string
region_list has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
function_list has a value which is a reference to a list where each element is a string
alias_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 Feature_id_mapping

=over 4



=item Description

@optional by_type by_region by_function by_alias


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string


=end text

=back



=head2 Feature_data

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
feature_id has a value which is a string
feature_type has a value which is a string
feature_function has a value which is a string
feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
feature_dna_sequence_length has a value which is an int
feature_dna_sequence has a value which is a string
feature_md5 has a value which is a string
feature_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
feature_publications has a value which is a reference to a list where each element is a string
feature_quality_warnings has a value which is a reference to a list where each element is a string
feature_quality_score has a value which is a reference to a list where each element is a string
feature_notes has a value which is a string
feature_inference has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
feature_id has a value which is a string
feature_type has a value which is a string
feature_function has a value which is a string
feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
feature_dna_sequence_length has a value which is an int
feature_dna_sequence has a value which is a string
feature_md5 has a value which is a string
feature_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
feature_publications has a value which is a reference to a list where each element is a string
feature_quality_warnings has a value which is a reference to a list where each element is a string
feature_quality_score has a value which is a reference to a list where each element is a string
feature_notes has a value which is a string
feature_inference has a value which is a string


=end text

=back



=head2 Protein_data

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
protein_id has a value which is a string
protein_amino_acid_sequence has a value which is a string
protein_function has a value which is a string
protein_aliases has a value which is a reference to a list where each element is a string
protein_md5 has a value which is a string
protein_domain_locations has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
protein_id has a value which is a string
protein_amino_acid_sequence has a value which is a string
protein_function has a value which is a string
protein_aliases has a value which is a reference to a list where each element is a string
protein_md5 has a value which is a string
protein_domain_locations has a value which is a reference to a list where each element is a string


=end text

=back



=head2 Exon_data

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
exon_location has a value which is a GenomeAnnotationAPI.Region
exon_dna_sequence has a value which is a string
exon_ordinal has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
exon_location has a value which is a GenomeAnnotationAPI.Region
exon_dna_sequence has a value which is a string
exon_ordinal has a value which is an int


=end text

=back



=head2 UTR_data

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
utr_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
utr_dna_sequence has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
utr_locations has a value which is a reference to a list where each element is a GenomeAnnotationAPI.Region
utr_dna_sequence has a value which is a string


=end text

=back



=head2 Summary_data

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
scientific_name has a value which is a string
taxonomy_id has a value which is an int
kingdom has a value which is a string
scientific_lineage has a value which is a reference to a list where each element is a string
genetic_code has a value which is an int
organism_aliases has a value which is a reference to a list where each element is a string
assembly_source has a value which is a string
assembly_source_id has a value which is a string
assembly_source_date has a value which is a string
gc_content has a value which is a float
dna_size has a value which is an int
num_contigs has a value which is an int
contig_ids has a value which is a reference to a list where each element is a string
external_source has a value which is a string
external_source_date has a value which is a string
release has a value which is a string
original_source_filename has a value which is a string
feature_type_counts has a value which is a reference to a hash where the key is a string and the value is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
scientific_name has a value which is a string
taxonomy_id has a value which is an int
kingdom has a value which is a string
scientific_lineage has a value which is a reference to a list where each element is a string
genetic_code has a value which is an int
organism_aliases has a value which is a reference to a list where each element is a string
assembly_source has a value which is a string
assembly_source_id has a value which is a string
assembly_source_date has a value which is a string
gc_content has a value which is a float
dna_size has a value which is an int
num_contigs has a value which is an int
contig_ids has a value which is a reference to a list where each element is a string
external_source has a value which is a string
external_source_date has a value which is a string
release has a value which is a string
original_source_filename has a value which is a string
feature_type_counts has a value which is a reference to a hash where the key is a string and the value is an int


=end text

=back



=head2 inputs_get_taxon

=over 4



=item Description

*
* Retrieve the Taxon associated with this GenomeAnnotation.
*
* @return Reference to TaxonAPI object


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference


=end text

=back



=head2 inputs_get_assembly

=over 4



=item Description

*
* Retrieve the Assembly associated with this GenomeAnnotation.
*
* @return Reference to AssemblyAPI object


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference


=end text

=back



=head2 inputs_get_feature_types

=over 4



=item Description

*
* Retrieve the list of Feature types.
*
* @return List of feature type identifiers (strings)


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference


=end text

=back



=head2 inputs_get_feature_type_descriptions

=over 4



=item Description

optional feature_type_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_type_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_type_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_feature_type_counts

=over 4



=item Description

@optional feature_type_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_type_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_type_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_feature_ids

=over 4



=item Description

@optional filters group_by


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
filters has a value which is a GenomeAnnotationAPI.Feature_id_filters
group_by has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
filters has a value which is a GenomeAnnotationAPI.Feature_id_filters
group_by has a value which is a string


=end text

=back



=head2 inputs_get_features

=over 4



=item Description

@optional feature_id_list exclude_sequence


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string
exclude_sequence has a value which is a GenomeAnnotationAPI.boolean

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string
exclude_sequence has a value which is a GenomeAnnotationAPI.boolean


=end text

=back



=head2 GetFeatures2Params

=over 4



=item Description

exclude_sequence = set to 1 (true) or 0 (false) to indicate if sequences
should be included.  Defautl is false.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string
exclude_sequence has a value which is a GenomeAnnotationAPI.boolean

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string
exclude_sequence has a value which is a GenomeAnnotationAPI.boolean


=end text

=back



=head2 inputs_get_proteins

=over 4



=item Description

*
* Retrieve Protein data.
*
* @return Mapping from protein ID to data about the protein.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference


=end text

=back



=head2 inputs_get_feature_locations

=over 4



=item Description

optional feature_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_feature_publications

=over 4



=item Description

optional feature_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_feature_dna

=over 4



=item Description

*
* Retrieve Feature DNA sequences.
*
* @param feature_id_list List of Feature IDs for which to retrieve sequences.
*     If empty, returns data for all features.
* @return Mapping of Feature IDs to their DNA sequence.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_feature_functions

=over 4



=item Description

@optional feature_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_feature_aliases

=over 4



=item Description

@optional feature_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
feature_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_cds_by_gene

=over 4



=item Description

*
* Retrieves coding sequence Features (cds) for given gene Feature IDs.
*
* @param gene_id_list List of gene Feature IDS for which to retrieve CDS.
*     If empty, returns data for all features.
* @return Mapping of gene Feature IDs to a list of CDS Feature IDs.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
gene_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
gene_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_mrna_id_list

=over 4



=item Description

@optional mrna_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_gene_by_cds

=over 4



=item Description

@optional cds_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
cds_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
cds_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_gene_by_mrna

=over 4



=item Description

@optional mrna_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_mrna_by_cds

=over 4



=item Description

@optional cds_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
cds_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
cds_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_mrna_by_gene

=over 4



=item Description

@optional gene_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
gene_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
gene_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_mrna_exons

=over 4



=item Description

@optional mrna_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_mrna_utrs

=over 4



=item Description

@optional mrna_id_list


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference
mrna_id_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 inputs_get_summary

=over 4



=item Description

*
* Retrieve a summary representation of this GenomeAnnotation.
*
* @return summary data


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference


=end text

=back



=head2 inputs_save_summary

=over 4



=item Description

*
* Retrieve a summary representation of this GenomeAnnotation.
*
* @return (int, Summary_data)


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a GenomeAnnotationAPI.ObjectReference


=end text

=back



=cut

package GenomeAnnotationAPI::GenomeAnnotationAPIClient::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
