namespace Elastica\Exception\Bulk;

/**
 * Bulk Response exception
 *
 * @package Elastica
 */
class ResponseException extends \Elastica\Exception\BulkException
{
    /**
     * Response
     *
     * @var \Elastica\Bulk\ResponseSet ResponseSet object
     */
    protected _responseSet;

    /**
     * @var \Elastica\Exception\Bulk\Response\ActionException[]
     */
    protected _actionExceptions = [];

    /**
     * Construct Exception
     *
     * @param \Elastica\Bulk\ResponseSet responseSet
     */
    public function __construct(<\Elastica\Bulk\ResponseSet> responseSet)
    {
        var message;

        this->_init(responseSet);

        let message = "Error in one or more bulk request actions:" . PHP_EOL . PHP_EOL;
        let message .= this->getActionExceptionsAsString();

        parent::__construct(message);
    }

    /**
     * @param \Elastica\Bulk\ResponseSet responseSet
     */
    protected function _init(<\Elastica\Bulk\ResponseSet> responseSet)
    {
        var bulkResponse, bulkResponses;

        let this->_responseSet = responseSet;
        let bulkResponses = responseSet->getBulkResponses();

        for bulkResponse in bulkResponses {
            if bulkResponse->hasError() {
                let this->_actionExceptions[] = new \Elastica\Exception\Bulk\Response\ActionException(bulkResponse);
            }
        }
    }

    /**
     * Returns bulk response set object
     *
     * @return \Elastica\Bulk\ResponseSet
     */
    public function getResponseSet() -> <\Elastica\Bulk\ResponseSet>
    {
        return this->_responseSet;
    }

    /**
     * Returns array of failed actions
     *
     * @return array Array of failed actions
     */
    public function getFailures() -> array
    {
        var actionException, actionExceptions, errors;
        let errors = [];
        let actionExceptions = this->getActionExceptions();

        for actionException in actionExceptions {
            let errors[] = actionException->getMessage();
        }

        return errors;
    }

    /**
     * @return \Elastica\Exception\Bulk\Response\ActionException[]
     */
    public function getActionExceptions() -> array
    {
        return this->_actionExceptions;
    }

    /**
     * @return string
     */
    public function getActionExceptionsAsString() -> string
    {
        var message, actionExceptions, actionException;

        let message = "";
        let actionExceptions = this->getActionExceptions();

        for actionException in actionExceptions {
            let message .= actionException->getMessage() . PHP_EOL;
        }

        return message;
    }
}