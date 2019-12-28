<?hh //partial
//We are in partial mode to be abble to access supperglobals, like $_GET, $_POST etc...
namespace Quasar\Component\Http;

use namespace HH\Lib\Dict;

class RequestFactory
{
    public static function createFromSuperGlobals(): Request
    {

        $server = dict[];

        foreach ($_SERVER as $key => $value) {
            $server[$key] = $value;
        }

        return new Request(
            new ParameterContainer(Dict\from_keys($_GET, (string $key) ==> $_GET[$key])),
            new ParameterContainer(Dict\from_keys($_POST, (string $key) ==> $_POST[$key])),
            new ParameterContainer(Dict\from_keys($_COOKIE, (string $key) ==> $_COOKIE[$key])),
            new ParameterContainer(Dict\from_keys($_FILES, (string $key) ==> $_FILES[$key])),
            new ParameterContainer($server)
        );
    }
}
