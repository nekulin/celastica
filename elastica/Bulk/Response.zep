namespace Elastica\Bulk;

class Response extends \Elastica\Response
{
    /**
     * @var \Elastica\Bulk\Action
     */
    protected _action;

    /**
     * @var string
     */
    protected _opType;

    /**
     * @param array|string responseData
     * @param \Elastica\Bulk\Action action
     * @param string opType
     */
    public function __construct(var responseData, <\Elastica\Bulk\Action> action, string opType) -> void
    {
        parent::__construct(responseData);

        let this->_action = action;
        let this->_opType = opType;
    }

    /**
     * @return \Elastica\Bulk\Action
     */
    public function getAction() -> <\Elastica\Bulk\Action>
    {
        return this->_action;
    }

    /**
     * @return string
     */
    public function getOpType() -> string
    {
        return this->_opType;
    }
}