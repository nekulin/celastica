namespace Elastica\Aggregation;

abstract class AbstractAggregation extends Param
{
    /**
     * The name of this aggregation
     * @var string
     */
    protected _name;

    /**
     * Subaggregations belonging to this aggregation
     * @var array
     */
    protected _aggs = [];

    /**
     * @param string name the name of this aggregation
     */
    public function __construct(string name) -> void
    {
        this->setName(name);
    }

    /**
     * Set the name of this aggregation
     * @param string name
     */
    public function setName(string name) -> void
    {
        let this->_name = name;
    }

    /**
     * Retrieve the name of this aggregation
     * @return string
     */
    public function getName() -> string
    {
        return this->_name;
    }

    /**
     * Retrieve all subaggregations belonging to this aggregation
     * @return array
     */
    public function getAggs() -> array
    {
        return this->_aggs;
    }

    /**
     * Add a sub-aggregation
     * @param AbstractAggregation aggregation
     * @return \Elastica\Aggregation\AbstractAggregation
     */
    public function addAggregation(aggregation)
    {
        let this->_aggs[aggregation->getName()] = aggregation->toArray();
        return this;
    }

    /**
     * @return array
     */
    public function toArray() -> array
    {
        var arr;
        let arr = parent::toArray();
        if (array_key_exists('global_aggregation', arr)) {
            // compensate for class name GlobalAggregation
            let arr['global'] = new \stdClass;
        }
        if (sizeof(this->_aggs)) {
            let arr['aggs'] = this->_aggs;
        }
        return arr;
    }
}