namespace Elastica\Filter;

/**
 * Returns parent documents having child docs matching the query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/has-child-filter.html
 */
class HasChild extends AbstractFilter
{
    /**
     * Construct HasChild filter
     *
     * @param string|\Elastica\Query|\Elastica\Filter\AbstractFilter query Query string or a Elastica\Query object or a filter
     * @param string                type  Parent document type
     */
    public function __construct(var query, string type = null) -> void
    {
        this->setType(type);
        if query instanceof \Elastica\Filter\AbstractFilter {
            this->setFilter(query);
        } else {
            this->setQuery(query);
        }
    }

    /**
     * Sets query object
     *
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @return \Elastica\Filter\HasChild                     Current object
     */
    public function setQuery(var query) -> <\Elastica\Filter\HasChild>
    {
        var data;
        let query = \Elastica\Query::create(query);
        let data = query->toArray();

        return this->setParam("query", data["query"]);
    }

    /**
     * Sets the filter object
     *
     * @param \Elastica\Filter\AbstractFilter filter
     * @return \Elastica\Filter\HasChild Current object
     */
    public function setFilter(<\Elastica\Filter\AbstractFilter> filter) -> <\Elastica\Filter\HasChild>
    {
        var data;
        let data = filter->toArray();
        return this->setParam("filter", data);
    }

    /**
     * Set type of the parent document
     *
     * @param  string                         type Parent document type
     * @return \Elastica\Filter\HasChild Current object
     */
    public function setType(string type) -> <\Elastica\Filter\HasChild>
    {
        return this->setParam("type", type);
    }

    /**
     * Sets the scope
     *
     * @param  string                         scope Scope
     * @return \Elastica\Filter\HasChild Current object
     */
    public function setScope(string scope) -> <\Elastica\Filter\HasChild>
    {
        return this->setParam("_scope", scope);
    }
}