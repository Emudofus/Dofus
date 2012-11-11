package org.flintparticles.common.renderers
{
    import org.flintparticles.common.emitters.*;

    public interface Renderer
    {

        public function Renderer();

        function addEmitter(param1:Emitter) : void;

        function removeEmitter(param1:Emitter) : void;

        function get emitters() : Array;

    }
}
