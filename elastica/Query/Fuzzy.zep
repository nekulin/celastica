namespace Elastica\Query;

/**
 * Fuzzy query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/fuzzy-query.html
 */
class Fuzzy extends AbstractQuery
{
    /**
     * Construct a fuzzy query
     *
     * @param  string                    fieldName Field name
     * @param  string                    value     String to search for
     */
    public function __construct (string fieldName = null, string value = null) -> void
    {
        if fieldName && value {
            this->setField(fieldName, value);
        }
    }

    /**
     * Set field for fuzzy query
     *
     * @param  string                    fieldName Field name
     * @param  string                    value     String to search for
     * @return \Elastica\Query\Fuzzy Current object
     */
    public function setField (string fieldName, string value) -> <\Elastica\Query\Fuzzy>
    {
        var data = [];
        if typeof value != "string" || typeof fieldName != "string" {
            throw new \Elastica\Exception\InvalidException("The field and value arguments must be of type string.");
        }
        if (count(this->getParams()) > 0 && array_shift(array_keys(this->getParams())) != fieldName) {
            throw new \Elastica\Exception\InvalidException("Fuzzy query can only support a single field.");
        }
        let data["value"] = value;
        return this->setParam(fieldName, data);
    }

    /**
     * Set optional parameters on the existing query
     *
     * @param  string                    param option name
     * @param  mixed                     value      Value of the parameter
     * @return \Elastica\Query\Fuzzy Current object
     */
    public function setFieldOption (string param, var value) -> <\Elastica\Query\Fuzzy>
    {
        //Retrieve the single existing field for alteration.
        var params, keyArray;
        let params = this->getParams();
        if (count(params) < 1) {
           throw new \Elastica\Exception\InvalidException("No field has been set");
        }
        let keyArray = array_keys(params);
        let params[keyArray[0]][param] = value;

        return this->setparam(keyArray[0], params[keyArray[0]]);
    }
}