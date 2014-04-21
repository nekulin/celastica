namespace Elastica\Filter;

/**
 * Query filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/query-filter.html
 */
class Query extends AbstractFilter
{
    /**
     * Query
     * @var array
     */
    protected _query;

    /**
     * Construct query filter
     *
     * @param array|\Elastica\Query\AbstractQuery query
     */
    public function __construct(var query = null)
    {
        if query != null {
            this->setQuery(query);
        }
    }

    /**
     * Set query
     *
     * @param  array|\Elastica\Query\AbstractQuery  query
     * @return \Elastica\Filter\Query         Query object
     * @throws \Elastica\Exception\InvalidException Invalid param
     */
    public function setQuery(var query) -> <\Elastica\Filter\Query>
    {
        if !(query instanceof \Elastica\Query\AbstractQuery) && !is_array(query) {
            throw new \Elastica\Exception\InvalidException("expected an array or instance of Elastica\Query\AbstractQuery");
        }

        if query instanceof \Elastica\Query\AbstractQuery {
            let query = query->toArray();
        }

        let this->_query = query;

        return this;
    }

    /**
     * @see \Elastica\Param::_getBaseName()
     */
    protected function _getBaseName()
    {
        if empty this->_params {
            return "query";
        } else {
            return "fquery";
        }
    }

    /**
     * @see \Elastica\Param::toArray()
     */
    public function toArray() -> array
    {
        var data, name, filterData;

        let data = parent::toArray();
        let name = this->_getBaseName();
        let filterData = data[name];

        if empty filterData {
            let filterData = this->_query;
        } else {
            let filterData["query"] = this->_query;
        }

        let data[name] = filterData;

        return data;
    }
}