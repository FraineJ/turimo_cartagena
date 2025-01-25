import Flutter
import UIKit
import GoogleMaps
import FirebaseCore
import UserNotifications // Para manejar notificaciones push

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Inicialización de Firebase
        FirebaseApp.configure()

        // Configuración de permisos de notificación
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if let error = error {
                print("Error al solicitar permisos de notificación: \(error.localizedDescription)")
            }
        }

        // Registro para notificaciones remotas
        application.registerForRemoteNotifications()

        // Inicialización de Google Maps
        GMSServices.provideAPIKey("AIzaSyCJxEN1YvH9frflvAc8xTmSnVFpZk2HAYU")

        // Registro de plugins generados
        GeneratedPluginRegistrant.register(with: self)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Método para registrar el token APNs
    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("Token APNs registrado: \(deviceToken)")
    }

    // Manejo de errores en el registro de notificaciones
    override func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Error al registrar para notificaciones remotas: \(error.localizedDescription)")
    }
}
