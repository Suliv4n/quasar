namespace App\Controller;

use type Quasar\Component\Http\Response;
use type Quasar\Component\Http\HttpStatusCodeEnum;

class HomeController
{
    public function index(): Response
    {
        return new Response(
            '<html><body>Hello world !</body></html>',
        );
    }
}