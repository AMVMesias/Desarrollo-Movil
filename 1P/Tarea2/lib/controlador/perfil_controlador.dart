import '../modelo/perfil_modelo.dart';

// Controlador que gestiona la lógica del perfil
class PerfilControlador {
  // Carga el perfil según el tipo de usuario
  PerfilModelo cargarPerfil(String tipoPerfil) {
    // Cargar perfil según el tipo
    if (tipoPerfil.toLowerCase() == 'mesias') {
      return PerfilModelo(
        nombre: 'Mesias',
        apellido: 'Orlando Mariscal',
        carrera: 'Software',
        telefono: '0960222440',
        edad: 22,
        email: '',
        sobreMi: 'Estudiante de Ingeniería en Software con experiencia en desarrollo web, aplicaciones móviles, inteligencia artificial y estructuras de datos.',
        githubUrl: 'https://github.com/AMVMesias?tab=repositories',
        habilidades: ['Python', 'JavaScript', 'TypeScript', 'Dart', 'C#', 'C++', 'HTML/CSS', 'Flutter'],
        experiencia: [
          Experiencia(empresa: 'Agente de Diagnóstico de Otitis con IA', cargo: 'Proyecto Académico', periodo: '2024', descripcion: 'Sistema de inteligencia artificial para diagnóstico de otitis usando Python.'),
          Experiencia(empresa: 'Snake con IA', cargo: 'Proyecto Personal', periodo: '2024', descripcion: 'Implementación del juego Snake con inteligencia artificial en Python.'),
          Experiencia(empresa: 'Árbol AVL', cargo: 'Proyecto de Estructuras de Datos', periodo: '2024', descripcion: 'Implementación de estructura de datos AVL en C++ con operaciones de balanceo.'),
          Experiencia(empresa: 'Cohen-Sutherland & Algoritmos Gráficos', cargo: 'Proyecto Académico', periodo: '2024', descripcion: 'Implementación de algoritmos gráficos en C# incluyendo Cohen-Sutherland y fractales.'),
          Experiencia(empresa: 'El Granito Finance Hub', cargo: 'Proyecto Web', periodo: '2024', descripcion: 'Aplicación web financiera desarrollada con TypeScript.'),
        ],
        educacion: [
          Educacion(institucion: 'Universidad de las Fuerzas Armadas ESPE', titulo: 'Ingeniería en Software', periodo: '2020 - Presente'),
        ],
      );
    } else if (tipoPerfil.toLowerCase() == 'gabriel') {
      return PerfilModelo(
        nombre: 'Gabriel',
        apellido: 'Murillo',
        carrera: 'Software',
        telefono: '097 872 4697',
        edad: 23,
        email: 'gamurigm@gmail.com',
        sobreMi: 'Actualmente estudiando en la Universidad de las Fuerzas Armadas ESPE, tengo experiencia desarrollando páginas web para negocios, aplicaciones móviles bajo pedido, y diseñando sistemas de análisis de datos con inteligencia artificial.',
        githubUrl: '',
        habilidades: ['TypeScript', 'JavaScript', 'Python', 'C++', 'Go', 'Angular', 'Flutter', 'React Native', 'TensorFlow', 'PyTorch', 'CUDA', 'Node.js', 'gRPC', 'PostgreSQL', 'MongoDB', 'Docker', 'Git'],
        experiencia: [
          Experiencia(empresa: 'Optimización Criptográfica con CUDA', cargo: 'Proyecto Académico', periodo: '2024', descripcion: 'Implementación del algoritmo AES en modo CTR utilizando CUDA para cifrado de bloques de 128 bits con paralelización.'),
          Experiencia(empresa: 'Distributed Load Balancer', cargo: 'Proyecto Académico', periodo: '2024', descripcion: 'Aplicación para distribuir tráfico de red entre múltiples servidores backend usando Go y gRPC.'),
        ],
        educacion: [
          Educacion(institucion: 'Universidad de las Fuerzas Armadas ESPE', titulo: 'Ingeniería en Software', periodo: '2022 - Presente'),
        ],
      );
    } else if (tipoPerfil.toLowerCase() == 'brayan') {
      return PerfilModelo(
        nombre: 'Bryan',
        apellido: 'Roberto Quispe Romero',
        carrera: 'Ingeniería de Software',
        telefono: '097 919 5854',
        edad: 25,
        email: '',
        sobreMi: 'Desarrollador web en formación. Me apasiona programar, hacer ejercicio y jugar videojuegos.',
        githubUrl: 'https://github.com/Bryan-Quispe?tab=repositories',
        habilidades: ['JavaScript', 'TypeScript', 'Python', 'C++', 'Dart', 'Flutter', 'React', 'HTML/CSS', 'Prolog'],
        experiencia: [
          Experiencia(empresa: 'Detector Perros vs Gatos con IA', cargo: 'Proyecto de Machine Learning', periodo: '2024', descripcion: 'Sistema de detección de perros y gatos usando redes neuronales implementado en sitio web.'),
          Experiencia(empresa: 'Escenario 3D', cargo: 'Proyecto de Gráficos', periodo: '2024', descripcion: 'Desarrollo de escenario tridimensional usando gráficos computacionales.'),
          Experiencia(empresa: 'Aplicaciones Distribuidas', cargo: 'Proyecto Académico', periodo: '2024', descripcion: 'Desarrollo de aplicaciones distribuidas usando Python y arquitecturas modernas.'),
          Experiencia(empresa: 'Computer Parts', cargo: 'Proyecto Web', periodo: '2024', descripcion: 'Aplicación web para gestión de componentes de computadoras con JavaScript.'),
          Experiencia(empresa: 'React con Vite', cargo: 'Proyecto Personal', periodo: '2024', descripcion: 'Curso y desarrollo de aplicaciones con React usando Vite como herramienta de construcción.'),
        ],
        educacion: [
          Educacion(institucion: 'Universidad de las Fuerzas Armadas ESPE', titulo: 'Ingeniería en Software', periodo: '2019 - Presente'),
        ],
      );
    }
    
    // Por defecto retornar perfil de mesias
    return PerfilModelo(
      nombre: 'Mesias',
      apellido: 'Orlando Mariscal',
      carrera: 'Software',
      telefono: '0960222440',
      edad: 22,
      email: '',
      sobreMi: 'Estudiante de Ingeniería en Software con experiencia en desarrollo web, aplicaciones móviles, inteligencia artificial y estructuras de datos.',
      githubUrl: 'https://github.com/AMVMesias?tab=repositories',
      habilidades: ['Python', 'JavaScript', 'TypeScript', 'Dart', 'C#', 'C++', 'HTML/CSS', 'Flutter'],
      experiencia: [
        Experiencia(empresa: 'Agente de Diagnóstico de Otitis con IA', cargo: 'Proyecto Académico', periodo: '2024', descripcion: 'Sistema de inteligencia artificial para diagnóstico de otitis usando Python.'),
        Experiencia(empresa: 'Snake con IA', cargo: 'Proyecto Personal', periodo: '2024', descripcion: 'Implementación del juego Snake con inteligencia artificial en Python.'),
        Experiencia(empresa: 'Árbol AVL', cargo: 'Proyecto de Estructuras de Datos', periodo: '2024', descripcion: 'Implementación de estructura de datos AVL en C++ con operaciones de balanceo.'),
        Experiencia(empresa: 'Cohen-Sutherland & Algoritmos Gráficos', cargo: 'Proyecto Académico', periodo: '2024', descripcion: 'Implementación de algoritmos gráficos en C# incluyendo Cohen-Sutherland y fractales.'),
        Experiencia(empresa: 'El Granito Finance Hub', cargo: 'Proyecto Web', periodo: '2024', descripcion: 'Aplicación web financiera desarrollada con TypeScript.'),
      ],
      educacion: [
        Educacion(institucion: 'Universidad de las Fuerzas Armadas ESPE', titulo: 'Ingeniería en Software', periodo: '2020 - Presente'),
      ],
    );
  }
}
