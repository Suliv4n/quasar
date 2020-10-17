namespace Quasar\Component\DependencyInjection\Argument;

interface ArgumentInterface<+T> {
    public function getValue(): T;
}