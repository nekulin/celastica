namespace Elastica\Aggregation;

/**
 * Class Missing
 * @package Elastica\Aggregation
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-aggregations-bucket-missing-aggregation.html
 */
class Missing extends AbstractAggregation
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
     * @return Missing
     */
    public function setField(string field) -> <\Elastica\Aggregation\Missing>
    {
        return this->setParam("field", field);
    }
}
