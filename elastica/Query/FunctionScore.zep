namespace Elastica\Query;

/**
 * Custom score query
 *
 * @package Elastica
 * @author Aris Kemper <aris.kemper@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/custom-score-query.html
 */
class CustomScore extends AbstractQuery
{
    /**
     * Constructor
     *
     * @param string|array|\Elastica\Script        script
     * @param string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     */
    public function __construct(var script = null, var query= null)
    {
        if script {
            this->setScript(script);
        }
        this->setQuery(query);
    }

    /**
     * Sets query object
     *
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery query
     * @return \Elastica\Query\CustomScore
     */
    public function setQuery(var query) -> <\Elastica\Query\CustomScore>
    {
        var data;
        let query = \Elastica\Query::create(query);
        let data = query->toArray();

        return this->setParam("query", data["query"]);
    }

    /**
     * Set script
     *
     * @param  string|\Elastica\Script          script
     * @return \Elastica\Query\CustomScore
     */
    public function setScript(var script) -> <\Elastica\Query\CustomScore>
    {
        var param, value;
        let script = \Elastica\Script::create(script);
        for param, value in script->toArray() {
            this->setParam(param, value);
        }

        return this;
    }

    /**
     * Add params
     *
     * @param  array                           params
     * @return \Elastica\Query\CustomScore
     */
    public function addParams(array params) -> <\Elastica\Query\CustomScore>
    {
        this->setParam("params", params);

        return this;
    }
}