namespace Elastica\Aggregation;

/**
 * Class Filter
 * @package Elastica\Aggregation
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-aggregations-bucket-filter-aggregation.html
 */
class Filter extends AbstractAggregation
{
    /**
     * Set the filter for this aggregation
     * @param AbstractFilter filter
     * @return Filter
     */
    public function setFilter(<\Elastica\Filter\AbstractFilter> filter) -> <\Elastica\Aggregation\Filter>
    {
        return this->setParam("filter", filter->toArray());
    }

    /**
     * @return array
     */
    public function toArray() -> array
    {
        return [
            "filter": this->getParam("filter"),
            "aggs": this->_aggs
        ];
    }
}