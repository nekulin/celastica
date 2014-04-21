namespace Elastica\Exception\Bulk\Response;

class ActionException extends \Elastica\Exception\BulkException
{
    /**
     * @var \Elastica\Response
     */
    protected _response;

    /**
     * @param \Elastica\Bulk\Response response
     */
    public function __construct(<\Elastica\Bulk\Response> response)
    {
        let this->_response = response;

        parent::__construct(this->getErrorMessage(response));
    }

    /**
     * @return \Elastica\Bulk\Action
     */
    public function getAction()
    {
        return this->getResponse()->getAction();
    }

    /**
     * @return \Elastica\Bulk\Response
     */
    public function getResponse() -> <\Elastica\Bulk\Response>
    {
        return this->_response;
    }

    /**
     * @param \Elastica\Bulk\Response response
     * @return string
     */
    public function getErrorMessage(<\Elastica\Bulk\Response> response) -> string
    {
        var error, opType, data, path, message;

        let error = response->getError();
        let opType = response->getOpType();
        let data = response->getData();

        let path = ""   ;
        if isset data["_index"] {
            let path .= "/" . data["_index"];
        }
        if isset data["_type"] {
            let path .= "/" . data["_type"];
        }
        if isset data["_id"] {
            let path .= "/" . data["_id"];
        }
        let message = "opType:" . path . "caused error";

        return message;
    }
}