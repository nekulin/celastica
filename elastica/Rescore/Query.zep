namespace Elastica\Rescore;

/**
 * Query Rescore
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/search/rescore/
 */
class Query extends AbstractRescore
{
    /**
     * Constructor
     *
     * @param string|\Elastica\Query\AbstractQuery rescoreQuery
     * @param string|\Elastica\Query\AbstractQuery query
     */
    public function __construct(var query = null)
    {
        this->setParam('query', []);
        this->setRescoreQuery(query);
    }

    /**
     * Override default implementation so params are in the format
     * expected by elasticsearch
     *
     * @return array Rescore array
     */
    public function toArray() -> array
    {
        var data;

        let data = this->getParams();

        if !empty this->_rawParams {
            let data = array_merge(data, this->_rawParams);
        }

        return data;
    }

    /**
     * Sets rescoreQuery object
     *
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery $query
     * @return \Elastica\Query\Rescore
     */
    public function setRescoreQuery(var rescoreQuery) -> <\Elastica\Query\Rescore>
    {
        var data;

        let query = \Elastica\Query::create(rescoreQuery);
        let data = query->toArray();

        let query = this->getParam('query');
        let query['rescore_query'] = data['query'];

        return this->setParam('query', query);
    }

    /**
     * Sets query_weight
     *
     * @param float weight
     * @return \Elastica\Query\Rescore
     */
    public function setQueryWeight(var weight) -> <\Elastica\Query\Rescore>
    {
        var query;

        let query = this->getParam('query');
        query['query_weight'] = weight;

        return this->setParam('query', query);
    }

    /**
     * Sets rescore_query_weight
     *
     * @param float size
     * @return \Elastica\Query\Rescore
     */
    public function setRescoreQueryWeight(var weight)
    {
        var query;

        let query = this->getParam('query');
        query['rescore_query_weight'] = weight;

        return this->setParam('query', query);
    }
}
