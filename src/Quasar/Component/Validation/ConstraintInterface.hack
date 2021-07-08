namespace Quasar\Component\Validation;

interface ConstraintInterface extends \HH\InstancePropertyAttribute
{
    public function validate(mixed $value): void;
}
