namespace Quasar\Component\DependencyInjection\Exception;

use type LogicException;

use namespace HH\Lib\Str;

class UnknownArgumentException extends DefinitionException
{
    public function __construct(string $classname, string $argumentName) {
        parent::__construct(
            Str\format(
                'Argument $%s was provided but class %s has no parameter with this name.',
                $classname,
                $argumentName
            )
        );
    }
}