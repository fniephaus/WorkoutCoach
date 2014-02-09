import QtQuick 2.0
import mtq.widgets 1.0
Rectangle {
    width: 200; height: 100
    Row {
        Image { id: img; sourceSize { width: 100; height: 100 } source: "source: "../resources/svg/WhiteArrow.svg"" }
        ShaderEffect {
            width: 100; height: 100
            property variant src: img
            vertexShader: "
                uniform highp mat4 qt_Matrix;
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                varying highp vec2 coord;
                void main() {
                    coord = qt_MultiTexCoord0;
                    gl_Position = qt_Matrix * qt_Vertex;
                }"
            fragmentShader: "
                varying highp vec2 coord;
                uniform sampler2D src;
                uniform lowp float qt_Opacity;
                void main() {
                    lowp vec4 tex = texture2D(src, coord);
                    gl_FragColor = vec4(vec3(dot(tex.rgb, vec3(0.344, 0.5, 0.156))), tex.a) * qt_Opacity;
                }"
        }
    }
}

