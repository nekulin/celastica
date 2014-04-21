namespace Elastica\Bulk;

class Action
{
    const OP_TYPE_CREATE = "create";
    const OP_TYPE_INDEX  = "index";
    const OP_TYPE_DELETE = "delete";
    const OP_TYPE_UPDATE = "update";

    /**
     * @var string
     */
    protected _opType;

    /**
     * @var array
     */
    protected _metadata = [];

    /**
     * @var array
     */
    protected _source = [];

    /**
     * @param string opType
     * @param array metadata
     * @param array source
     */
    public function __construct(var opType, array metadata = [], array source = []) -> void
    {
        if opType == null {
            let opType = self::OP_TYPE_INDEX;
        }

        this->setOpType(opType);
        this->setMetadata(metadata);
        this->setSource(source);
    }

    public function __init()
    {

    }

    /**
     * @param string type
     * @return \Elastica\Bulk\Action
     */
    public function setOpType(string type) -> <\Elastica\Bulk\Action>
    {
        let this->_opType = type;

        return this;
    }

    /**
     * @return string
     */
    public function getOpType() -> string
    {
        return this->_opType;
    }

    /**
     * @param array metadata
     * @return \Elastica\Bulk\Action
     */
    public function setMetadata(var metadata) -> <\Elastica\Bulk\Action>
    {
        let this->_metadata = metadata;

        return this;
    }

    /**
     * @return array
     */
    public function getMetadata() -> array
    {
        return this->_metadata;
    }

    /**
     * @return array
     */
    public function getActionMetadata() -> array
    {
        var arr;
        let arr = [];
        let arr[this->_opType] = this->getMetadata();
        return arr;
    }

    /**
     * @param array source
     * @return \Elastica\Bulk\Action
     */
    public function setSource(var source) -> <\Elastica\Bulk\Action>
    {
        let this->_source = source;

        return this;
    }

    /**
     * @return array
     */
    public function getSource() -> array
    {
        return this->_source;
    }

    /**
     * @return bool
     */
    public function hasSource() -> boolean
    {
        return !empty(this->_source);
    }

    /**
     * @param string|\Elastica\Index index
     * @return \Elastica\Bulk\Action
     */
    public function setIndex(var index) -> <\Elastica\Bulk\Action>
    {
        if index instanceof \Elastica\Index {
            let index = index->getName();
        }
        let this->_metadata["_index"] = index;

        return this;
    }

    /**
     * @param string|\Elastica\Type type
     * @return \Elastica\Bulk\Action
     */
    public function setType(var type) -> <\Elastica\Bulk\Action>
    {
        if type instanceof \Elastica\Type {
            this->setIndex(type->getIndex()->getName());
            let type = type->getName();
        }
        let this->_metadata["_type"] = type;

        return this;
    }

    /**
     * @param string id
     * @return \Elastica\Bulk\Action
     */
    public function setId(string id) -> <\Elastica\Bulk\Action>
    {
        let this->_metadata["_id"] = id;

        return this;
    }

    /**
     * @return array
     */
    public function toArray() -> array
    {
        var data;
        let data = [];
        let data[] = this->getActionMetadata();
        if this->hasSource() {
            let data[] = this->getSource();
        }
        return data;
    }

    /**
     * @return string
     */
    public function toString() -> string
    {
        var str, source;
        let str = json_encode(this->getActionMetadata(), JSON_FORCE_OBJECT) . \Elastica\Bulk::DELIMITER;
        if this->hasSource() {
            let source = this->getSource();
            if typeof source == "string" {
                let str .= source;
            } else {
                let str .= json_encode(source);
            }
            let str .= \Elastica\Bulk::DELIMITER;
        }
        return str;
    }

    /**
     * @param string opType
     * @return bool
     */
    public static function isValidOpType(string opType) -> boolean
    {
        var types;

        let types = [
            self::OP_TYPE_CREATE,
            self::OP_TYPE_INDEX,
            self::OP_TYPE_DELETE,
            self::OP_TYPE_UPDATE
        ];

        return in_array(opType, types);
    }
}
