namespace Quasar\Component\DependencyInjection\Exception;

use type LogicException;

use namespace HH\Lib\Str;

class NoServiceFoundForClassException extends LogicException {
    public function __construct(
        string $serviceId,
        string $parameterName,
        varray<string> $triedAliases,
    ) {
        parent::__construct(
            Str\format(
                'Fail to autowire Service %s. Missing required parameter value for %s, trying these aliases :\n%s',
                $serviceId,
                $parameterName,
                Str\join($triedAliases, ', '),
            ),
        );
    }
}
