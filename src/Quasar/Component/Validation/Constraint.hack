namespace Quasar\Component\Validation;

use type Quasar\Component\Validation\Exception\ConstraintViolationException;

abstract class Constraint implements ConstraintInterface
{
    public function __construct(
        private string $message
    ) {}

    public final function isValid(mixed $value): bool {
        try {
            $this->validate($value);
            return true;
        } catch (ConstraintViolationException $exception) {
            return false;
        }
    }
}