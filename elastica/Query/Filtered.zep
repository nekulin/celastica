namespace Elastica\Query;

/**
 * Filtered query. Needs a query and a filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/filtered-query.html
 */
class Filtered extends AbstractQuery
{
    /**
     * Query
     *
     * @var \Elastica\Query\AbstractQuery Query object
     */
    protected _query = null;

    /**
     * Filter
     *
     * @var \Elastica\Filter\AbstractFilter Filter object
     */
    protected _filter = null;

    /**
     * Constructs a filtered query
     *
     * @param \Elastica\Query\AbstractQuery   query  Query object
     * @param \Elastica\Filter\AbstractFilter filter Filter object
     */
    public function __construct(<\Elastica\Query\AbstractQuery> query, <\Elastica\Filter\AbstractFilter> filter) -> void
    {
        this->setQuery(query);
        this->setFilter(filter);
    }

    /**
     * Sets a query
     *
     * @param  \Elastica\Query\AbstractQuery query Query object
     * @return \Elastica\Query\Filtered      Current object
     */
    public function setQuery(<\Elastica\Query\AbstractQuery> query) -> <\Elastica\Query\Filtered>
    {
        let this->_query = query;

        return this;
    }

    /**
     * Sets the filter
     *
     * @param  \Elastica\Filter\AbstractFilter filter Filter object
     * @return \Elastica\Query\Filtered        Current object
     */
    public function setFilter(<\Elastica\Filter\AbstractFilter> filter) -> <\Elastica\Query\Filtered>
    {
        let this->_filter = filter;

        return this;
    }

    /**
     * Gets the filter.
     *
     * @return \Elastica\Filter\AbstractFilter
     */
    public function getFilter() -> <\Elastica\Filter\AbstractFilter>
    {
        return this->_filter;
    }

    /**
     * Gets the query.
     *
     * @return \Elastica\Query\AbstractQuery
     */
    public function getQuery() -> <\Elastica\Query\AbstractQuery>
    {
        return this->_query;
    }

    /**
     * Converts query to array
     *
     * @return array Query array
     * @see \Elastica\Query\AbstractQuery::toArray()
     */
    public function toArray() -> array
    {
        var data = [];
        let data["filtered"]["query"] = this->_query->toArray();
        let data["filtered"]["filter"] = this->_filter->toArray();
        return data;
    }
}