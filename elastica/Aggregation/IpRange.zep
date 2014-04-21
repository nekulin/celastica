namespace Elastica\Aggregation;

/**
 * Class IpRange
 * @package Elastica\Aggregation
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-aggregations-bucket-iprange-aggregation.html
 */
class IpRange extends AbstractAggregation
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
     * @return IpRange
     */
    public function setField(field) -> <\Elastica\Aggregation\IpRange>
    {
        return this->setParam("field", field);
    }

    /**
     * Add an ip range to this aggregation
     * @param string fromValue a valid ipv4 address. Low end of this range, exclusive (greater than)
     * @param string toValue a valid ipv4 address. High end of this range, exclusive (less than)
     * @return IpRange
     * @throws \Elastica\Exception\InvalidException
     */
    public function addRange(string fromValue = null, string toValue = null) -> <\Elastica\Aggregation\IpRange>
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
     * Add an ip range in the form of a CIDR mask
     * @param string mask a valid CIDR mask
     * @return IpRange
     */
    public function addMaskRange(string mask) -> <\Elastica\Aggregation\IpRange>
    {
        return this->addParam("ranges", ["mask": mask]);
    }
}
