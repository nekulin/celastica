namespace Elastica\Query;

/**
 * Bool query
 *
 * @package Elastica
 * @author Aris Kemper <aris.kemper@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/bool-query.html
 */
class BoolQuery extends AbstractQuery
{
    /**
     * Add should part to query
     *
     * @param  \Elastica\Query\AbstractQuery|array args Should query
     * @return \Elastica\Query\Bool           Current object
     */
    public function addShould(array args) -> <\Elastica\Query\Bool>
    {
        return this->_addQuery('should', args);
    }

    /**
     * Add must part to query
     *
     * @param  \Elastica\Query\AbstractQuery|array args Must query
     * @return \Elastica\Query\Bool           Current object
     */
    public function addMust(array args) -> <\Elastica\Query\Bool>
    {
        return this->_addQuery('must', args);
    }

    /**
     * Add must not part to query
     *
     * @param  \Elastica\Query\AbstractQuery|array args Must not query
     * @return \Elastica\Query\Bool           Current object
     */
    public function addMustNot(array args) -> <\Elastica\Query\Bool>
    {
        return this->_addQuery('must_not', args);
    }

    /**
     * Adds a query to the current object
     *
     * @param  string                              type Query type
     * @param  \Elastica\Query\AbstractQuery|array  args Query
     * @return \Elastica\Query\Bool
     * @throws \Elastica\Exception\InvalidException If not valid query
     */
    protected function _addQuery(string type, array args) -> <\Elastica\Query\Bool>
    {
        if (args instanceof \Elastica\Query\AbstractQuery) {
            args = args->toArray();
        }

        if !is_array(args) {
            throw new \Elastica\Exception\InvalidException('Invalid parameter. Has to be array or instance of Elastica\Query\AbstractQuery');
        }

        return this->addParam(type, args);
    }

    /**
     * Sets boost value of this query
     *
     * @param  float               boost Boost value
     * @return \Elastica\Query\Bool Current object
     */
    public function setBoost(float boost) -> <\Elastica\Query\Bool>
    {
        return this->setParam('boost', boost);
    }

    /**
     * Set the minimum number of of should match
     *
     * @param  int                 minimumNumberShouldMatch Should match minimum
     * @return \Elastica\Query\Bool Current object
     */
    public function setMinimumNumberShouldMatch(int minimumNumberShouldMatch) -> <\Elastica\Query\Bool>
    {
        return this->setParam('minimum_number_should_match', minimumNumberShouldMatch);
    }
}