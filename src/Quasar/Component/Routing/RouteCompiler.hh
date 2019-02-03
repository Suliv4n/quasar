<?hh //strict
namespace Quasar\Component\Routing;

use namespace HH\Lib\Str;
use namespace HH\Lib\Regex;


class RouteCompiler
{
    const REGEX_DELIMITER = "`";

    /**
     * Compile a route. Translate the route pattern to regex.
     *
     * @param Route $route The route to compile.
     */
    public function compile(Route $route) : CompiledRoute
    {
        list($regex, $routeParameters) = $this->compileRegex($route);
        $compiledRoute = new CompiledRoute($regex, $routeParameters);

        return $compiledRoute;
    }

    /**
     * Compile the route pattern to regex et parameters requirements.
     * 
     * @param Route $route The route to compile.
     *
     * @return string Regex compiled from route pattern and parameters requirements.
     */
    private function compileRegex(Route $route) : (string, Vector<RouteParameter>)
    {
        $pattern = $route->getPattern();
        $regex = "";

        $matches = Regex\every_match($pattern, re"/\{(\w+)\}/");

        if (\count($matches) === 0)
        {
            return tuple(
                self::REGEX_DELIMITER . \preg_quote($pattern, self::REGEX_DELIMITER) . self::REGEX_DELIMITER,
                Vector{}
            );
        }

        $position = 0;
        $routeParameters = Vector{};
        foreach($matches as $i => $match)
        {
            $parameter = $match[0];
            $parameterName = $match[1];

            $compiledParameter = $this->compileParameter($parameterName, $route->getRequirements());
            
            $parameterPosition = \strpos($pattern, $parameter, $position);
            $regexPart = \substr($pattern, $position, $parameterPosition - $position) 
                |> \preg_quote($$, self::REGEX_DELIMITER) 
                |> $$ . $compiledParameter;

            $position = $parameterPosition + Str\length($parameter);

            $regex .= $regexPart;

            $routeParameters[] = new RouteParameter($parameterName);
        }

        $regex = self::REGEX_DELIMITER . $regex . self::REGEX_DELIMITER;

        return tuple($regex, $routeParameters);
    }

    /**
     * Compile a route parameter to regex, based on requirements.
     * 
     * @param string $parameter The route parameter name to compile.
     * @param Map<string, string> $requirements The route parameter requirements.
     * 
     * @return string The parameter regex. 
     */
    private function compileParameter(string $parameter, Map<string, string> $requirements) : string
    {
        $parameterRegex = "(.+)";

        if ($requirements->containsKey($parameter))
        {
            $parameterRegex = (
                $requirements[$parameter] 
                |> $this->replaceRegexCapturingGroupsToNonCapturingGroups($$)
                |> "(" . $$ . ")"
            );
        }

        if (!$this->isValidRegex(self::REGEX_DELIMITER . $parameterRegex . self::REGEX_DELIMITER))
        {
            throw new \LogicException(\sprintf("The regex requirement \"%s\" of parameter %s is not a valid regex.", $parameterRegex, $parameter));
        }

        return $parameterRegex;
    }

    /**
     * Check if string is a valid regex.
     *
     * @param string $string The string to check.
     *
     * @return bool True if the string is a valid refex, else false.
     */
    private function isValidRegex(string $string) : bool
    {
        /* HH_FIXME[4118] This expression is always true [4118] */
        return @\preg_match($string, "") !== false;
    }


    /**
     * Replace capturing groups in a regex to non capturing groups (using :?).
     *
     * @param string $regex The regex to convert groups.
     *
     * @return string The converting regex.
     */
    private function replaceRegexCapturingGroupsToNonCapturingGroups(string $regex) : string
    {
        $length = Str\length($regex);
        for ($i = 0; $i < $length; ++$i)
        {
            if ($regex[$i] === '\\')
            {
                ++$i;
                continue;
            }

            if ($regex[$i] !== '(' || $length < $i + 2)
            {
                continue;
            }

            if ($regex[++$i] === '*' || $regex[$i] === '?')
            {
                ++$i;
                continue;
            }

            $regex = \substr_replace($regex, '?:', $i, 0);
            ++$i;
        }
        return $regex;
    }
}