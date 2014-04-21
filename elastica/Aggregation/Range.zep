namespace Elastica\Aggregation;

/**
 * Class Range
 * @package Elastica\Aggregation
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-aggregations-bucket-range-aggregation.html
 */
class Range extends AbstractSimpleAggregation
{
    /**
     * Add a range to this aggregation
     * @param int|float fromValue low end of this range, exclusive (greater than)
     * @param int|float toValue high end of this range, exclusive (less than)
     * @return Range
     * @throws \Elastica\Exception\InvalidException
     */
    public function addRange(var fromValue = null, var toValue = null) -> <\Elastica\Aggregation\Range>
    {
        var range;
        let range = [];

        if fromValue == null && toValue == null {
            throw new \Elastica\Exception\InvalidException("Either fromValue or toValue must be set. Both cannot be null.");
        }

        if fromValue != null {
            let range["from"] = fromValue;
        }
        if toValue != null {
            let range["to"] = toValue;
        }
        return this->addParam("ranges", range);
    }

    /**
     * If set to true, a unique string key will be associated with each bucket, and ranges will be returned as an associative array
     * @param bool keyed
     * @return Range
     */
    public function setKeyedResponse(boolean keyed = true) -> <\Elastica\Aggregation\Range>
    {
        return this->setParam("keyed", keyed);
    }
}