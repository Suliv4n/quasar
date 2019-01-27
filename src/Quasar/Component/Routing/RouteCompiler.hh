<?hh //strict
namespace Quasar\Component\Routing;

use namespace HH\Lib\Str;
use namespace HH\Lib\Regex;

class RouteCompiler
{
    const REGEX_DELIMITER = "`";

    public function compile(Route $route) : CompiledRoute
    {
        $regex = $this->compileRegex($route);
        $compiledRoute = new CompiledRoute($regex);

        return $compiledRoute;
    }

    private function compileRegex(Route $route) : string
    {
        $pattern = $route->getPattern();
        $regex = $pattern;

        $matches = Regex\every_match($pattern, re"/\{(\w+)\}/");

        foreach($matches as $i => $match)
        {
            $parameter = $match[0];
            $parameterName = $match[1];

            $compiledParameter = $this->compileParameter($parameterName, $route->getRequirements());

            $regex = Str\replace($regex, $parameter, $compiledParameter);
        }

        $regex = self::REGEX_DELIMITER . $regex . self::REGEX_DELIMITER;

        return $regex;
    }

    private function compileParameter(string $parameter, Map<string, string> $requirements) : string
    {
        $parameterRegex = "(.*)";

        if ($requirements->containsKey($parameter))
        {
            $parameterRegex = "(" . $requirements[$parameter] . ")";
        }

        if (!$this->isValidRegex(self::REGEX_DELIMITER . $parameterRegex . self::REGEX_DELIMITER))
        {
            throw new \LogicException(\sprintf("The regex requirement \"%s\" of parameter %s is not a valid regex.", $parameterRegex, $parameter));
        }

        return $parameterRegex;
    }

    private function isValidRegex(string $string) : bool
    {
        /* HH_FIXME[4118] This expression is always true [4118] */
        return @\preg_match($string, "") !== false;
    }
}