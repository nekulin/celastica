namespace Elastica\Facet;

/**
 * Implements the range facet.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/search/facets/range-facet.html
 */
class Range extends AbstractFacet
{
    /**
     * Sets the field for the range.
     *
     * @param  string                    field The name of the field for range.
     * @return \Elastica\Facet\Range
     */
    public function setField(field) -> <\Elastica\Facet\Range>
    {
        return this->setParam("field", field);
    }

    /**
     * Sets the fields by their separate key and value fields.
     *
     * @param  string                    keyField   The key_field param for the range.
     * @param  string                    valueField The key_value param for the range.
     * @return \Elastica\Facet\Range
     */
    public function setKeyValueFields(keyField, valueField) -> <\Elastica\Facet\Range>
    {
        return this->setParam("key_field", keyField)
                    ->setParam("value_field", valueField);
    }

    /**
     * Sets the key and value for this facet by script.
     *
     * @param string keyScript   Script to check whether it falls into the range.
     * @param string valueScript Script to use for statistical calculations.
     *
     * @return \Elastica\Facet\Range
     */
    public function setKeyValueScripts(keyScript, valueScript) -> <\Elastica\Facet\Range>
    {
        return this->setParam("key_script", keyScript)
                    ->setParam("value_script", valueScript);
    }

    /**
     * Sets the ranges for the facet all at once. Sample ranges:
     * array (
     *     array("to" => 50),
     *     array("from" => 20, "to" 70),
     *     array("from" => 70, "to" => 120),
     *     array("from" => 150)
     * )
     *
     * @param  array                     ranges Numerical array with range definitions.
     * @return \Elastica\Facet\Range
     */
    public function setRanges(array ranges) -> <\Elastica\Facet\Range>
    {
        return this->setParam("ranges", ranges);
    }

    /**
     * Adds a range to the range facet.
     *
     * @param  mixed                     from The from for the range.
     * @param  mixed                     to   The to for the range.
     * @return \Elastica\Facet\Range
     */
    public function addRange(var from = null, var to = null) -> <\Elastica\Facet\Range>
    {
        if !isset this->_params["ranges"] || typeof this->_params["ranges"] != "array" {
            let this->_params["ranges"] = [];
        }

        var range = [];
        if from  {
            let range["from"] = from;
        }
        if to {
            let range["to"] = to;
        }
        //todo
        //let this->_params["ranges"][] = range;

        return this;
    }

    /**
     * Creates the full facet definition, which includes the basic
     * facet definition of the parent.
     *
     * @see \Elastica\Facet\AbstractFacet::toArray()
     * @throws \Elastica\Exception\InvalidException When the right fields haven"t been set.
     * @return array
     */
    public function toArray()
    {
        /**
         * Check the facet for validity.
         * There are three ways to set the key and value field for the range:
         *  - a single field for both key and value; or
         *  - separate fields for key and value; or
         *  - separate scripts for key and value.
         */
        var fieldTypesSet;

        let fieldTypesSet = 0;
        if isset this->_params["field"] {
            let fieldTypesSet++;
        }
        if isset this->_params["key_field"] {
            let fieldTypesSet++;
        }
        if isset this->_params["key_script"] {
            let fieldTypesSet++;
        }

        if fieldTypesSet === 0 {
            throw new \Elastica\Exception\InvalidException("Neither field, key_field nor key_script is set.");
        } else {
            if fieldTypesSet > 1 {
                throw new \Elastica\Exception\InvalidException("Either field, key_field and key_value or key_script and value_script should be set.");
            }
        }

        /**
         * Set the range in the abstract as param.
         */
        this->_setFacetParam("range", this->_params);

        return parent::toArray();
    }
}