namespace Elastica\Aggregation;

/**
 * Class Nested
 * @package Elastica\Aggregation
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-aggregations-bucket-nested-aggregation.html
 */
class Nested extends AbstractAggregation
{
    /**
     * @param string name the name of this aggregation
     * @param string path the nested path for this aggregation
     */
    public function __construct(string name, string path) -> void
    {
        parent::__construct(name);
        this->setPath(path);
    }

    /**
     * Set the nested path for this aggregation
     * @param string path
     * @return Nested
     */
    public function setPath(string path) -> <\Elastica\Aggregation\Nested>
    {
        return this->setParam("path", path);
    }
}
