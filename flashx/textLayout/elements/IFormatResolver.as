package flashx.textLayout.elements
{
    import flashx.textLayout.formats.*;

    public interface IFormatResolver
    {

        public function IFormatResolver();

        function invalidateAll(param1:TextFlow) : void;

        function invalidate(param1:Object) : void;

        function resolveFormat(param1:Object) : ITextLayoutFormat;

        function resolveUserFormat(param1:Object, param2:String);

        function getResolverForNewFlow(param1:TextFlow, param2:TextFlow) : IFormatResolver;

    }
}
