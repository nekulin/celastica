namespace Elastica;

/**
 * Elastica log object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Log
{
    /**
     * Log path or true if enabled
     *
     * @var string|bool
     */
    protected _log = true;

    /**
     * Last logged message
     *
     * @var string Last logged message
     */
    protected _lastMessage = "";

    /**
     * Inits log object
     *
     * @param string|bool String to set a specific file for logging
     */
    public function __construct(var log = null)
    {
        if log == null {
            let log = "";
        }
        this->setLog(log);
    }

    /**
     * Log a message
     *
     * @param mixed level
     * @param string message
     * @param array context
     * @return null|void
     */
    public function log(var level, string message, array context = [])
    {
        let context["error_message"] = message;
        let this->_lastMessage = json_encode(context);

        if !empty this->_log && typeof this->_log == "string" {
            error_log(this->_lastMessage . PHP_EOL, 3, this->_log);
        } else {
            error_log(this->_lastMessage);
        }

    }

    /**
     * Enable/disable log or set log path
     *
     * @param  bool|string $log Enables log or sets log path
     * @return \Elastica\Log
     */
    public function setLog(var log) -> <\Elastica\Log>
    {
        let this->_log = log;

        return this;
    }

    /**
     * Return last logged message
     *
     * @return string Last logged message
     */
    public function getLastMessage() -> string
    {
        return this->_lastMessage;
    }
}