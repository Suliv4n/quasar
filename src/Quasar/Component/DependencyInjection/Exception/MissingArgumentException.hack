namespace Quasar\Component\DependencyInjection\Exception;

use type LogicException;

use namespace HH\Lib\Str;

class MissingArgumentException extends DefinitionException
{
    public function __construct(string $classname, string $argumentName) {
        parent::__construct(
            Str\format(
                'Constructor of class %s require an argument $%s that was not provided,
                have no default value and does not allow null.',
                $classname,
                $argumentName
            )
        );
    }
}