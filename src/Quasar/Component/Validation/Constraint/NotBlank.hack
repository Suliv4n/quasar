namespace Quasar\Component\Valildation\Constraint;

use type Quasar\Component\Validation\Constraint;
use type Quasar\Component\Validation\Exception\ConstraintViolationException;

use namespace HH\Lib\Dict;

type NotBlankOptions = shape(
    ?'allowNull' => bool,
    ?'normalizer' => ?(function(string): mixed)
);

class NotBlank extends Constraint
{
    public function __construct(
        private string $message,
        private ?NotBlankOptions $options = shape(),
    ) {
        parent::__construct($message);
    }

    public function validate(mixed $value): void
    {
        $normalizer = $this->options['normalizer'] ?? null;
        $allowNull = $this->options['allowNull'] ?? false;

        if (
            !($normalizer is null)
            && $value is string
        ) {
            $value = $normalizer($value);
        }

        if ($allowNull && null === $value) {
            return;
        }

        if (
            $value === false
            || $value === null
            || $value === 0
            || $value === '0'
            || $value === ''
        ) {
            throw new ConstraintViolationException($this->message);
        }
    }
}