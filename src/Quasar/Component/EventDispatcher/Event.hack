namespace Quasar\Component\EventDispatcher;

abstract class Event
{
    private bool $propagationStopped = false;

    public final function stopPropagation(): void
    {
        $this->propagationStopped = true;
    }
}