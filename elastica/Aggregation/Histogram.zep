namespace Elastica\Aggregation;

/**
 * Class Histogram
 * @package Elastica\Aggregation
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-aggregations-bucket-histogram-aggregation.html
 */
class Histogram extends AbstractSimpleAggregation
{
    /**
     * @param string name the name of this aggregation
     * @param string field the name of the field on which to perform the aggregation
     * @param int interval the interval by which documents will be bucketed
     */
    public function __construct(string name, string field, int interval) -> void
    {
        parent::__construct(name);
        this->setField(field);
        this->setInterval(interval);
    }


    /**
     * Set the interval by which documents will be bucketed
     * @param int interval
     * @return Histogram
     */
    public function setInterval(int interval) -> <\Elastica\Aggregation\Histogram>
    {
        return this->setParam("interval", interval);
    }

    /**
     * Set the bucket sort order
     * @param string order "_count", "_term", or the name of a sub-aggregation or sub-aggregation response field
     * @param string direction "asc" or "desc"
     * @return Histogram
     */
    public function setOrder(string order, string direction) -> <\Elastica\Aggregation\Histogram>
    {
        return this->setParam("order", [order: direction]);
    }

    /**
     * Set the minimum number of documents which must fall into a bucket in order for the bucket to be returned
     * @param int count set to 0 to include empty buckets
     * @return Histogram
     */
    public function setMinimumDocumentCount(int count) -> <\Elastica\Aggregation\Histogram>
    {
        return this->setParam("min_doc_count", count);
    }
}
