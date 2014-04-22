namespace Elastica\Query;

/**
 * QueryString query
 *
 * @package  Elastica
 * @author   Aris Kemper <aris.github@gmail.com>
 * @link     http://www.elasticsearch.org/guide/reference/query-dsl/query-string-query.html
 */
class QueryString extends AbstractQuery
{
    /**
     * Query string
     *
     * @var string Query string
     */
    protected _queryString = "";

    /**
     * Creates query string object. Calls setQuery with argument
     *
     * @param string queryString OPTIONAL Query string for object
     */
    public function __construct(string queryString = "")
    {
        this->setQuery(queryString);
    }

    /**
     * Sets a new query string for the object
     *
     * @param  string                              query Query string
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Query\QueryString     Current object
     */
    public function setQuery(string query = "") -> <\Elastica\Query\QueryString>
    {
        if typeof query != "string" {
            throw new \Elastica\Exception\InvalidException("Parameter has to be a string");
        }

        return this->setParam("query", query);
    }

    /**
     * Sets the default field
     *
     * If no field is set, _all is chosen
     *
     * @param  string                          field Field
     * @return \Elastica\Query\QueryString Current object
     */
    public function setDefaultField(string field) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("default_field", field);
    }

    /**
     * Sets the default operator AND or OR
     *
     * If no operator is set, OR is chosen
     *
     * @param  string                          operator Operator
     * @return \Elastica\Query\QueryString Current object
     */
    public function setDefaultOperator(string operator) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("default_operator", operator);
    }

    /**
     * Sets the analyzer to analyze the query with.
     *
     * @param  string                          analyzer Analyser to use
     * @return \Elastica\Query\QueryString Current object
     */
    public function setAnalyzer(string analyzer) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("analyzer", analyzer);
    }

    /**
     * Sets the parameter to allow * and ? as first characters.
     *
     * If not set, defaults to true.
     *
     * @param  bool                            allow
     * @return \Elastica\Query\QueryString Current object
     */
    public function setAllowLeadingWildcard(boolean allow = true) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("allow_leading_wildcard", allow);
    }

    /**
     * Sets the parameter to auto-lowercase terms of some queries.
     *
     * If not set, defaults to true.
     *
     * @param  bool                            lowercase
     * @return \Elastica\Query\QueryString Current object
     */
    public function setLowercaseExpandedTerms(boolean lowercase = true) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("lowercase_expanded_terms", lowercase);
    }

    /**
     * Sets the parameter to enable the position increments in result queries.
     *
     * If not set, defaults to true.
     *
     * @param  bool                            enabled
     * @return \Elastica\Query\QueryString Current object
     */
    public function setEnablePositionIncrements(boolean enabled = true) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("enable_position_increments", enabled);
    }

    /**
     * Sets the fuzzy prefix length parameter.
     *
     * If not set, defaults to 0.
     *
     * @param  int                             length
     * @return \Elastica\Query\QueryString Current object
     */
    public function setFuzzyPrefixLength(int length = 0) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("fuzzy_prefix_length", length);
    }

    /**
     * Sets the fuzzy minimal similarity parameter.
     *
     * If not set, defaults to 0.5
     *
     * @param  float                           minSim
     * @return \Elastica\Query\QueryString Current object
     */
    public function setFuzzyMinSim(var minSim = 0.5) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("fuzzy_min_sim", minSim);
    }

    /**
     * Sets the phrase slop.
     *
     * If zero, exact phrases are required.
     * If not set, defaults to zero.
     *
     * @param  int                             phraseSlop
     * @return \Elastica\Query\QueryString Current object
     */
    public function setPhraseSlop(int phraseSlop = 0) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("phrase_slop", phraseSlop);
    }

    /**
     * Sets the boost value of the query.
     *
     * If not set, defaults to 1.0.
     *
     * @param  float                           boost
     * @return \Elastica\Query\QueryString Current object
     */
    public function setBoost(var boost = 1.0) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("boost", boost);
    }

    /**
     * Allows analyzing of wildcard terms.
     *
     * If not set, defaults to true
     *
     * @param  bool                            analyze
     * @return \Elastica\Query\QueryString Current object
     */
    public function setAnalyzeWildcard(boolean analyze = true) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("analyze_wildcard", analyze);
    }

    /**
     * Sets the param to automatically generate phrase queries.
     *
     * If not set, defaults to true.
     *
     * @param  bool                            autoGenerate
     * @return \Elastica\Query\QueryString Current object
     */
    public function setAutoGeneratePhraseQueries(boolean autoGenerate = true) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("auto_generate_phrase_queries", autoGenerate);
    }

    /**
     * Sets the fields
     *
     * If no fields are set, _all is chosen
     *
     * @param  array                               fields Fields
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Query\QueryString     Current object
     */
    public function setFields(array fields) -> <\Elastica\Query\QueryString>
    {
        if (!is_array(fields)) {
            throw new \Elastica\Exception\InvalidException("Parameter has to be an array");
        }

        return this->setParam("fields", fields);
    }

    /**
     * Whether to use bool or dis_max queries to internally combine results for multi field search.
     *
     * @param  bool                            value Determines whether to use
     * @return \Elastica\Query\QueryString Current object
     */
    public function setUseDisMax(boolean value = true) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("use_dis_max", value);
    }

    /**
     * When using dis_max, the disjunction max tie breaker.
     *
     * If not set, defaults to 0.
     *
     * @param  int                             tieBreaker
     * @return \Elastica\Query\QueryString Current object
     */
    public function setTieBreaker(int tieBreaker = 0) -> <\Elastica\Query\QueryString>
    {
        return this->setParam("tie_breaker", tieBreaker);
    }

    /**
     * Set a re-write condition. See https://github.com/elasticsearch/elasticsearch/issues/1186 for additional information
     *
     * @param  string                          rewrite
     * @return \Elastica\Query\QueryString Current object
     */
    public function setRewrite(string rewrite = "") -> <\Elastica\Query\QueryString>
    {
        return this->setParam("rewrite", rewrite);
    }

    /**
     * Converts query to array
     *
     * @see \Elastica\Query\AbstractQuery::toArray()
     * @return array Query array
     */
    public function toArray() -> array
    {
        var data = [], arr = [];
        let data["query"] = this->_queryString;
        let arr["query_string"] = array_merge(data, this->getParams());
        return arr;
    }
}