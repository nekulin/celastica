namespace Elastica\Query;

/**
 * Returns child documents having parent docs matching the query
 *
 * @package Elastica
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/has-parent-query.html
 */
class HasParent extends AbstractQuery
{
    /**
     * Construct HasChild Query
     *
     * @param string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @param string                type  Parent document type
     */
    public function __construct(var query, string type)
    {
        this->setQuery(query);
        this->setType(type);
    }

    /**
     * Sets query object
     *
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @return \Elastica\Filter\HasParent
     */
    public function setQuery(var query) -> <\Elastica\Filter\HasParent>
    {
        var data;
        let query = \Elastica\Query::create(query);
        let data = query->toArray();

        return this->setParam("query", data["query"]);
    }

    /**
     * Set type of the parent document
     *
     * @param  string                          type Parent document type
     * @return \Elastica\Filter\HasParent Current object
     */
    public function setType(string type) -> <\Elastica\Filter\HasParent>
    {
        return this->setParam("type", type);
    }

    /**
     * Sets the scope
     *
     * @param  string                          scope Scope
     * @return \Elastica\Filter\HasParent Current object
     */
    public function setScope(string scope) -> <\Elastica\Filter\HasParent>
    {
        return this->setParam("_scope", scope);
    }
}