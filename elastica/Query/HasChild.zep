namespace Elastica\Query;

/**
 * Returns parent documents having child docs matching the query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/has-child-query.html
 */
class HasChild extends AbstractQuery
{
    /**
     * Construct HasChild Query
     *
     * @param string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @param string                type  Parent document type
     */
    public function __construct(var query, string type = null) -> void
    {
        this->setType(type);
        this->setQuery(query);
    }

    /**
     * Sets query object
     *
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @return \Elastica\Query\HasChild
     */
    public function setQuery(var query) -> <\Elastica\Query\HasChild>
    {
        var data;
        let query = \Elastica\Query::create(query);
        let data = query->toArray();

        return this->setParam("query", data["query"]);
    }

    /**
     * Set type of the parent document
     *
     * @param  string                       type Parent document type
     * @return \Elastica\Query\HasChild Current object
     */
    public function setType(string type) -> <\Elastica\Query\HasChild>
    {
        return this->setParam("type", type);
    }

    /**
     * Sets the scope
     *
     * @param  string                       scope Scope
     * @return \Elastica\Query\HasChild Current object
     */
    public function setScope(string scope) -> <\Elastica\Query\HasChild>
    {
        return this->setParam("_scope", scope);
    }
}