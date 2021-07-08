namespace Quasar\Component\Validation\Contraint;

use type Quasar\Component\Valildation\Constraint\NotBlank;
use type Quasar\Component\Validation\Exception\ConstraintViolationException;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;

class NotBlankTest extends HackTest
{
    public function testValidValues() : void
    {
        $constraint = new NotBlank('This value is not valid');
        expect($constraint->isValid('Not blank'))->toBeTrue();

        $constraint = new NotBlank('Null is allowed', shape('allowNull' => true));
        expect($constraint->isValid(null))->toBeTrue();

        $constraint = new NotBlank(
            'This is always valid',
            shape('normalizer' => (string $value) ==> $value . '1')
        );
        expect($constraint->isValid(''))->toBeTrue();
    }

    public function testInvalidValues() : void
    {
        $constraint = new NotBlank('This value is not valid');
        expect(() ==> $constraint->validate(''))->toThrow(ConstraintViolationException::class);

        $constraint = new NotBlank('Null is not allowed');
        expect(() ==> $constraint->validate(null))->toThrow(ConstraintViolationException::class);

        $constraint = new NotBlank(
            'Invalid with normalizer',
            shape('normalizer' => \HH\fun('trim'))
        );
        expect(() ==> $constraint->validate('     '))->toThrow(ConstraintViolationException::class);
    }
}
