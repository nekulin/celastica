namespace Elastica\Filter;

/**
 * Ids Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/ids-filter.html
 */
class Ids extends AbstractFilter
{
    /**
     * Creates filter object
     *
     * @param string|\Elastica\Type type Type to filter on
     * @param array                ids  List of ids
     */
    public function __construct(var type = null, array ids = []) -> void
    {
        this->setType(type);
        this->setIds(ids);
    }

    /**
     * Adds one more filter to the and filter
     *
     * @param  string                    id Adds id to filter
     * @return \Elastica\Filter\Ids Current object
     */
    public function addId(string id) -> <\Elastica\Filter\Ids>
    {
        return this->addParam("values", id);
    }

    /**
     * Adds one more type to query
     *
     * @param  string|\Elastica\Type      type Type name or object
     * @return \Elastica\Filter\Ids Current object
     */
    public function addType(var type) -> <\Elastica\Filter\Ids>
    {
        if type instanceof \Elastica\Type {
            let type = type->getName();
        } else {
            if empty type && !is_numeric(type) {
                // TODO: Shouldn"t this throw an exception?
                // A type can be 0, but cannot be empty
                return this;
            }
        }

        return this->addParam("type", type);
    }

    /**
     * Set type
     *
     * @param  string|\Elastica\Type      type Type name or object
     * @return \Elastica\Filter\Ids Current object
     */
    public function setType(var type) -> <\Elastica\Filter\Ids>
    {
        if type instanceof \Elastica\Type {
            let type = type->getName();
        } else {
            if empty type && !is_numeric(type) {
                // TODO: Shouldn"t this throw an exception or let handling of invalid params to ES?
                // A type can be 0, but cannot be empty
                return this;
            }
        }

        return  this->setParam("type", type);
    }

    /**
     * Sets the ids to filter
     *
     * @param  array|string              ids List of ids
     * @return \Elastica\Filter\Ids Current object
     */
    public function setIds(var ids)
    {
        if typeof ids == "array" {
            let ids = [ids];
        }

        return this->setParam("values", ids);
    }
}