namespace Elastica\Query;

/**
 * Runs the child query with an estimated hits size, and out of the hit docs, aggregates it into parent docs.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/top-children-query.html
 */
class TopChildren extends AbstractQuery
{
    /**
     * Construct topChildren query
     *
     * @param string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @param string                type  Parent document type
     */
    public function __construct(var query, string type = null) -> void
    {
        this->setQuery(query);
        this->setType(type);
    }

    /**
     * Sets query object
     *
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @return \Elastica\Query\TopChildren
     */
    public function setQuery(var query) -> <\Elastica\Query\TopChildren>
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
     * @return \Elastica\Query\TopChildren Current object
     */
    public function setType(string type) -> <\Elastica\Query\TopChildren>
    {
        return this->setParam("type", type);
    }
}