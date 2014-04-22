namespace Elastica;

/**
 * Elastica Response object
 *
 * Stores query time, and result array -> is given to result set, returned by ...
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Response
{
    /**
     * Query time
     *
     * @var float Query time
     */
    protected _queryTime = null;

    /**
     * Response string (json)
     *
     * @var string Response
     */
    protected _responseString = "";

    /**
     * Error
     *
     * @var boolean Error
     */
    protected _error = false;

    /**
     * Transfer info
     *
     * @var array transfer info
     */
    protected _transferInfo = [];

    /**
     * Response
     *
     * @var \Elastica\Response Response object
     */
    protected _response = null;

    /**
     * HTTP response status code
     *
     * @var int
     */
    protected _status = null;

    /**
     * Construct
     *
     * @param string|array responseString Response string (json)
     * @param int responseStatus http status code
     */
    public function __construct(var responseString, int responseStatus = null) -> void
    {
        if typeof responseString == "array" {
            let this->_response = responseString;
        } else {
            let this->_responseString = responseString;
        }
        let this->_status = responseStatus;
    }

    /**
     * Error message
     *
     * @return string Error message
     */
    public function getError() -> string
    {
        var message = "", response;
        let response = this->getData();

        return isset response["error"] ? response["error"] : message;
    }

    /**
     * True if response has error
     *
     * @return bool True if response has error
     */
    public function hasError() -> boolean
    {
        var response;
        let response = this->getData();

        return isset response["error"] ? true : false;
    }

    /**
     * Checks if the query returned ok
     *
     * @return bool True if ok
     */
    public function isOk()
    {
        var item, data;
        let data = this->getData();

        // Bulk insert checks. Check every item
        if isset data["status"] {
            return data["status"] >= 200 && data["status"] <= 300;
        }
        if isset data["items"] {
            for item in data["items"] {
                if false == item["index"]["ok"] {
                    return false;
                }
            }

            return true;
        }

        if this->_status >= 200 && this->_status <= 300 {
            // http status is ok
            return true;
        }

        return isset(data["ok"]) && data["ok"];
    }

    /**
     * @return int
     */
    public function getStatus()
    {
        return this->_status;
    }


    /**
     * Response data array
     *
     * @return array Response data array
     */
    public function getData()
    {
        var response, tempResponse;
        if this->_response == null {
            let response = this->_responseString;
            if response === false {
                let this->_error = true;
            } else {

                let tempResponse = json_decode(response, true);
                // Check if decoding went as expected. If error is returned, json_decode makes empty string of string
                if (json_last_error() == JSON_ERROR_NONE) {
                    response = tempResponse;
                }
            }

            if empty response {
                let response = [];
            }

            if typeof response == "string" {
                let response["message"] = response;
            }

            let this->_response = response;
        }

        return this->_response;
    }

    /**
     * Gets the transfer information.
     *
     * @return array Information about the curl request.
     */
    public function getTransferInfo()
    {
        return this->_transferInfo;
    }

    /**
     * Sets the transfer info of the curl request. This function is called
     * from the \Elastica\Client::_callService .
     *
     * @param  array transferInfo The curl transfer information.
     * @return \Elastica\Response Current object
     */
    public function setTransferInfo(var transferInfo) -> <\Elastica\Response>
    {
        let this->_transferInfo = transferInfo;
        return this;
    }

    /**
     * This is only available if DEBUG constant is set to true
     *
     * @return float Query time
     */
    public function getQueryTime() -> var
    {
        return this->_queryTime;
    }

    /**
     * Sets the query time
     *
     * @param  float queryTime Query time
     * @return \Elastica\Response Current object
     */
    public function setQueryTime(var queryTime) -> <\Elastica\Response>
    {
        let this->_queryTime = queryTime;
        return this;
    }

    /**
     * Time request took
     *
     * @throws \Elastica\Exception\NotFoundException
     * @return int                                  Time request took
     */
    public function getEngineTime() -> int
    {
        var data;
        let data = this->getData();

        if !isset data["took"] {
            throw new \Elastica\Exception\NotFoundException("Unable to find the field [took]from the response");
        }

        return data["took"];
    }

    /**
     * Get the _shard statistics for the response
     *
     * @throws \Elastica\Exception\NotFoundException
     * @return array
     */
    public function getShardsStatistics() -> array
    {
        var data;
        let data = this->getData();

        if !isset data["_shards"] {
            throw new \Elastica\Exception\NotFoundException("Unable to find the field [_shards] from the response");
        }

        return data["_shards"];
    }

    /**
     * Get the _scroll value for the response
     *
     * @throws \Elastica\Exception\NotFoundException
     * @return string
     */
    public function getScrollId() -> string
    {
        var data;
        let data = this->getData();

        if !isset data["_scroll_id"] {
            throw new \Elastica\Exception\NotFoundException("Unable to find the field [_scroll_id] from the response");
        }

        return data["_scroll_id"];
    }
}
