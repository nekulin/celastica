namespace Elastica\Aggregation;

/**
 * Class GeohashGrid
 * @package Elastica\Aggregation
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-aggregations-bucket-geohashgrid-aggregation.html
 */
class GeohashGrid extends AbstractAggregation
{
    /**
    * @param string name the name of this aggregation
    * @param string field the field on which to perform this aggregation
    */
    public function __construct(string name, string field) -> void
    {
        parent::__construct(name);
        this->setField(field);
    }

    /**
    * Set the field for this aggregation
    * @param string field the name of the document field on which to perform this aggregation
    * @return GeohashGrid
    */
    public function setField(string field) -> <\Elastica\Aggregation\GeohashGrid>
    {
        return this->setParam("field", field);
    }

    /**
    * Set the precision for this aggregation
    * @param int precision an integer between 1 and 12, inclusive. Defaults to 5.
    * @return GeohashGrid
    */
    public function setPrecision(int precision) -> <\Elastica\Aggregation\GeohashGrid>
    {
        return this->setParam("precision", precision);
    }

    /**
    * Set the maximum number of buckets to return
    * @param int size defaults to 10,000
    * @return GeohashGrid
    */
    public function setSize(int size) -> <\Elastica\Aggregation\GeohashGrid>
    {
        return this->setParam("size", size);
    }

    /**
    * Set the number of results returned from each shard
    * @param int shardSize
    * @return GeohashGrid
    */
    public function setShardSize(int shardSize) -> <\Elastica\Aggregation\GeohashGrid>
    {
        return this->setParam("shard_size", shardSize);
    }
}
