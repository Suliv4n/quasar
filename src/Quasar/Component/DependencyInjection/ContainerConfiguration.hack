namespace Quasar\Component\DependencyInjection;

use namespace HH\Lib\Str;
use type \stdClass;

class ContainerConfiguration {

    private vec<ServiceDefinition<nonnull>> $services = vec[];

    public function addServiceDefinition<T as nonnull>(ServiceDefinition<T> $service): ContainerConfiguration {
        $this->services[] = $service;
        
        return $this;
    }

    public function getServiceDefinition<<<__Enforceable>> reify T as nonnull>(
        ?string $id = null
    ): ServiceDefinition<T> {
        foreach ($this->services as $serviceDefinition) {
            if (
                \is_a($serviceDefinition->getServiceClass(), T::class, true)
                && ($id === null || $serviceDefinition->getId() === $id)
            ) {
                /**
                 * Return type is valid as "is_a($serviceDefinition->getServiceClass(), T::class, true)" is true.
                 */
                /* HH_FIXME[4110] Invalid return type */
                return $serviceDefinition;
            }
        }

        throw new \LogicException(
            Str\format(
                'No service of class %s was found.',
                T::class . ($id is nonnull ?  ' with id ' . $id : ''),
            )
        );
    }
}