namespace Elastica\Query;

/**
 * Match query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/match-query.html
 */
class Match extends AbstractQuery
{
    /**
     * Sets a param for the message array
     *
     * @param  string                    field
     * @param  mixed                     values
     * @return \Elastica\Query\Match
     */
    public function setField(string field, var values) -> <\Elastica\Query\Match>
    {
        return this->setParam(field, values);
    }

    /**
     * Sets a param for the given field
     *
     * @param  string                    field
     * @param  string                    key
     * @param  string                    value
     * @return \Elastica\Query\Match
     */
    public function setFieldParam(string field, string key, string value) -> <\Elastica\Query\Match>
    {
        if !isset this->_params[field] {
            let this->_params[field] = [];
        }

        let this->_params[field][key] = value;

        return this;
    }

    /**
     * Sets the query string
     *
     * @param  string                    field
     * @param  string                    query
     * @return \Elastica\Query\Match
     */
    public function setFieldQuery(string field, string query) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "query", query);
    }

    /**
     * Set field type
     *
     * @param  string                    field
     * @param  string                    type
     * @return \Elastica\Query\Match
     */
    public function setFieldType(string field, string type) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "type", type);
    }

    /**
     * Set field operator
     *
     * @param  string                    field
     * @param  string                    operator
     * @return \Elastica\Query\Match
     */
    public function setFieldOperator(string field, string operator) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "operator", operator);
    }

    /**
     * Set field analyzer
     *
     * @param  string                    field
     * @param  string                    analyzer
     * @return \Elastica\Query\Match
     */
    public function setFieldAnalyzer(string field, string analyzer) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "analyzer", analyzer);
    }

    /**
     * Set field boost value
     *
     * If not set, defaults to 1.0.
     *
     * @param  string                    field
     * @param  float                     boost
     * @return \Elastica\Query\Match
     */
    public function setFieldBoost(string field, var boost = 1.0) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "boost", (float) boost);
    }

    /**
     * Set field minimum should match
     *
     * @param  string                    field
     * @param  int|string                       minimumShouldMatch
     * @return \Elastica\Query\Match
     * @link Possible values for minimum_should_match http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-minimum-should-match.html
     */
    public function setFieldMinimumShouldMatch(string field, var minimumShouldMatch) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "minimum_should_match", minimumShouldMatch);
    }

    /**
     * Set field fuzziness
     *
     * @param  string                    field
     * @param  float                     fuzziness
     * @return \Elastica\Query\Match
     */
    public function setFieldFuzziness(string field, var fuzziness) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "fuzziness", (float) fuzziness);
    }

    /**
     * Set field fuzzy rewrite
     *
     * @param  string                    field
     * @param  string                    fuzzyRewrite
     * @return \Elastica\Query\Match
     */
    public function setFieldFuzzyRewrite(string field, string fuzzyRewrite) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "fuzzy_rewrite", fuzzyRewrite);
    }

    /**
     * Set field prefix length
     *
     * @param  string                    field
     * @param  int                       prefixLength
     * @return \Elastica\Query\Match
     */
    public function setFieldPrefixLength(string field, int prefixLength) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "prefix_length", prefixLength);
    }

    /**
     * Set field max expansions
     *
     * @param  string                    field
     * @param  int                       maxExpansions
     * @return \Elastica\Query\Match
     */
    public function setFieldMaxExpansions(string field, int maxExpansions) -> <\Elastica\Query\Match>
    {
        return this->setFieldParam(field, "max_expansions", (int) maxExpansions);
    }
}