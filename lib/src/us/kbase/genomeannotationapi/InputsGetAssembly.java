
package us.kbase.genomeannotationapi;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: inputs_get_assembly</p>
 * <pre>
 * *
 * * Retrieve the Assembly associated with this GenomeAnnotation.
 * *
 * * @return Reference to AssemblyAPI object
 * </pre>
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "ref"
})
public class InputsGetAssembly {

    @JsonProperty("ref")
    private String ref;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("ref")
    public String getRef() {
        return ref;
    }

    @JsonProperty("ref")
    public void setRef(String ref) {
        this.ref = ref;
    }

    public InputsGetAssembly withRef(String ref) {
        this.ref = ref;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((("InputsGetAssembly"+" [ref=")+ ref)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
