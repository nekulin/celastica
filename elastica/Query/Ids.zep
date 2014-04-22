namespace Elastica\Query;

/**
 * Ids Query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/ids-query.html
 */
class Ids extends AbstractQuery
{
    /**
     * Params
     *
     * @var array Params
     */
    protected _params = [];

    /**
     * Creates filter object
     *
     * @param string|\Elastica\Type type Type to filter on
     * @param array                ids  List of ids
     */
    public function __construct(string type = null, array ids = [])
    {
        this->setType(type);
        this->setIds(ids);
    }

    /**
     * Adds one more filter to the and filter
     *
     * @param  string                  id Adds id to filter
     * @return \Elastica\Query\Ids Current object
     */
    public function addId(string id) -> <\Elastica\Query\Ids>
    {
        //todo
        //let this->_params["values"][] = id;

        return this;
    }

    /**
     * Adds one more type to query
     *
     * @param  string|\Elastica\Type    type Type name or object
     * @return \Elastica\Query\Ids Current object
     */
    public function addType(var type) -> <\Elastica\Query\Ids>
    {
        if type instanceof \Elastica\Type {
            let type = type->getName();
        } else {
            if empty type && !is_numeric(type) {
                // A type can be 0, but cannot be empty
                return this;
            }
        }

        //todo
        //let this->_params["type"][] = type;

        return this;
    }

    /**
     * Set type
     *
     * @param  string|\Elastica\Type type Type name or object
     * @return \Elastica\Query\Ids   Current object
     */
    public function setType(var type) -> <\Elastica\Query\Ids>
    {
        if type instanceof \Elastica\Type {
            let type = type->getName();
        } else {
            if empty type && !is_numeric(type) {
                // A type can be 0, but cannot be empty
                return this;
            }
        }

        let this->_params["type"] = type;

        return this;
    }

    /**
     * Sets the ids to filter
     *
     * @param  array|string            ids List of ids
     * @return \Elastica\Query\Ids Current object
     */
    public function setIds(ids) -> <\Elastica\Query\Ids>
    {
        if typeof ids == "array" {
            let this->_params["values"] = ids;
        } else {
            let this->_params["values"] = [ids];
        }

        return this;
    }

    /**
     * Converts filter to array
     *
     * @see \Elastica\Query\AbstractQuery::toArray()
     * @return array Query array
     */
    public function toArray() -> array
    {
        var data = [];
        let data["ids"] = this->_params;
        return data;
    }
}