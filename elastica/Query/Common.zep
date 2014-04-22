namespace Elastica\Query;


/**
 * Class Common
 * @package Elastica
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/common-terms-query/
 */
class Common extends AbstractQuery
{
    const OPERATOR_AND = "and";
    const OPERATOR_OR = "or";

    /**
     * @var string
     */
    protected _field;

    /**
     * @var array
     */
    protected _queryParams = [];

    /**
     * @param string field the field on which to query
     * @param string query the query string
     * @param float cutoffFrequency percentage in decimal form (.001 == 0.1%)
     */
    public function __construct(string field, string query, var cutoffFrequency) -> void
    {
        this->setField(field);
        this->setQuery(query);
        this->setCutoffFrequency(cutoffFrequency);
    }

    /**
     * Set the field on which to query
     * @param string field the field on which to query
     * @return \Elastica\Query\Common
     */
    public function setField(string field) -> <\Elastica\Query\Common>
    {
        let this->_field = field;
        return this;
    }

    /**
     * Set the query string for this query
     * @param string query
     * @return \Elastica\Query\Common
     */
    public function setQuery(string query) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("query", query);
    }

    /**
     * Set the frequency below which terms will be put in the low frequency group
     * @param float frequency percentage in decimal form (.001 == 0.1%)
     * @return \Elastica\Query\Common
     */
    public function setCutoffFrequency(var frequency) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("cutoff_frequency", (float)frequency);
    }

    /**
     * Set the logic operator for low frequency terms
     * @param string operator see OPERATOR_* class constants for options
     * @return \Elastica\Query\Common
     */
    public function setLowFrequencyOperator(string operator) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("low_freq_operator", operator);
    }

    /**
     * Set the logic operator for high frequency terms
     * @param string operator see OPERATOR_* class constants for options
     * @return \Elastica\Query\Common
     */
    public function setHighFrequencyOperator(string operator) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("high_frequency_operator", operator);
    }

    /**
     * Set the minimum_should_match parameter
     * @param int|string minimum minimum number of low frequency terms which must be present
     * @return \Elastica\Query\Common
     * @link Possible values for minimum_should_match http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-minimum-should-match.html
     */
    public function setMinimumShouldMatch(var minimum) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("minimum_should_match", minimum);
    }

    /**
     * Set the boost for this query
     * @param float boost
     * @return \Elastica\Query\Common
     */
    public function setBoost(var boost) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("boost", (float)boost);
    }

    /**
     * Set the analyzer for this query
     * @param string analyzer
     * @return \Elastica\Query\Common
     */
    public function setAnalyzer(string analyzer) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("analyzer", analyzer);
    }

    /**
     * Enable / disable computation of score factor based on the fraction of all query terms contained in the document
     * @param bool disable disable_coord is false by default
     * @return \Elastica\Query\Common
     */
    public function setDisableCoord(boolean disable = true) -> <\Elastica\Query\Common>
    {
        return this->setQueryParam("disable_coord", disable);
    }

    /**
     * Set a parameter in the body of this query
     * @param string key parameter key
     * @param mixed value parameter value
     * @return \Elastica\Query\Common
     */
    public function setQueryParam(string key, var value) -> <\Elastica\Query\Common>
    {
        let this->_queryParams[key] = value;
        return this;
    }

    /**
     * @return array
     */
    public function toArray() -> array
    {
        this->setParam(this->_field, this->_queryParams);
        return parent::toArray();
    }
}