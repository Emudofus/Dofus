package com.ankamagames.jerakine.resources.loaders
{
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.resources.loaders.impl.*;

    public class ResourceLoaderFactory extends Object
    {

        public function ResourceLoaderFactory()
        {
            return;
        }// end function

        public static function getLoader(param1:uint) : IResourceLoader
        {
            switch(param1)
            {
                case ResourceLoaderType.PARALLEL_LOADER:
                {
                    return new ParallelRessourceLoader(JerakineConstants.MAX_PARALLEL_LOADINGS);
                }
                case ResourceLoaderType.SERIAL_LOADER:
                {
                    return new ParallelRessourceLoader(1);
                }
                case ResourceLoaderType.SINGLE_LOADER:
                {
                    return new SingleRessourceLoader();
                }
                default:
                {
                    break;
                }
            }
            throw new ArgumentError("Unknown loader type " + param1 + ".");
        }// end function

    }
}
