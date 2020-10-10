namespace Quasar\Component\DependencyInjection;

use namespace HH\Lib\Str;

/**
 * This class contains services definitions.
 */
class ContainerConfiguration {

    /**
     * Services definitions
     */
    private vec<ServiceDefinition<nonnull>> $services = vec[];

    /**
     * Add a service definition.
     * 
     * @param ServiceDefinition<T as nonnull> $service The service definition to add.
     * 
     * @return self
     */
    public function addServiceDefinition<T as nonnull>(ServiceDefinition<T> $service): ContainerConfiguration {
        $this->services[] = $service;

        return $this;
    }

    /**
     * Get a service definition by its type.
     * 
     * @param ?string $id Id of service definition to return.
     * 
     * @return ServiceDifinition
     */
    public function getServiceDefinition<<<__Enforceable>> reify T>(
        classname<T> $serviceClass,
        ?string $id = null
    ): ServiceDefinition<T> {
        foreach ($this->services as $serviceDefinition) {
            if (
                $serviceDefinition->getServiceClass() is T
                && ($id === null || $serviceDefinition->getId() === $id)
            ) {
                return $serviceDefinition;
            }
        }

        throw new \LogicException(
            Str\format(
                'No service of class %s was found.',
                $serviceClass . ($id is nonnull ?  ' with id ' . $id : ''),
            )
        );
    }
}