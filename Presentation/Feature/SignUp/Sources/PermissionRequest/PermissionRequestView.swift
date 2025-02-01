//
//  PermissionRequestView.swift
//  SignUp
//
//  Created by eunseou on 1/14/25.
//

import SwiftUI
import DesignSystem
import UseCases

struct PermissionRequestView: View {
  @State var viewModel: PermissionRequestViewModel
  @Environment(\.dismiss) private var dismiss
  @Environment(\.scenePhase) private var scenePhase

  var body: some View {
    ZStack {
      Color.grayscaleWhite.ignoresSafeArea()
      VStack(alignment: .center, spacing: 0) {
        VStack(spacing: 16) {
          title
          
          PermissionItem(
            icon: DesignSystemAsset.Icons.cameraLine32.swiftUIImage,
            title: "사진, 카메라",
            description: "프로필 생성 시 사진 첨부를 위해 필요해요.",
            isRequired: true
          )
          
          Divider(weight: .normal, isVertical: false)
          
          PermissionItem(
            icon: DesignSystemAsset.Icons.alarm32.swiftUIImage,
            title: "알림",
            description: "매칭 현황 등 중요 메세지 수신을 위해 필요해요.",
            isRequired: false
          )
          
          Divider(weight: .normal, isVertical: false)
          
          PermissionItem(
            icon: DesignSystemAsset.Icons.cellLine32.swiftUIImage,
            title: "연락처",
            description: "지인을 수집하기 위해 필요해요.",
            isRequired: false
          )
        }
        
        Spacer()
        
        nextButton
      }
      .padding([.horizontal, .top], 20)
      .padding(.bottom, 10)
    }
    .task {
       await viewModel.checkPermissions()
       viewModel.setDismissAction { dismiss() }
    }
    .onChange(of: scenePhase) {
      if scenePhase == .active {
        Task {
          await viewModel.checkPermissions()
        }
      }
    }
    .navigationBarModifier {
      NavigationBar(
        title: "",
        leftButtonTap: { viewModel.handleAction(.tapBackButton) }
      )
    }
    .alert("필수 권한 요청", isPresented: $viewModel.shouldShowSettingsAlert) {
      Button("설정으로 이동") {
        viewModel.handleAction(.showShettingAlert)
      }
      Button("취소", role: .cancel) {
        viewModel.handleAction(.cancelAlert)
      }
    } message: {
      Text("사진, 카메라 권한이 필요합니다. 설정에서 권한을 허용해주세요.")
    }
  }

  private var title: some View {
    VStack(alignment: .leading) {
      Text("편리한 Piece 이용을 위해")
      Text("아래 ") +
      Text("권한 허용")
        .foregroundStyle(Color.primaryDefault) +
      Text("이 필요해요")
    }
    .pretendard(.heading_L_SB)
    .foregroundStyle(Color.grayscaleBlack)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.bottom, 120)
  }
  
  private var nextButton: some View {
    RoundedButton(
      type: viewModel.nextButtonType ,
      buttonText: "다음",
      action: { viewModel.handleAction(.tapNextButton) }
    )
  }
  
  private func PermissionItem(
    icon: Image,
    title: String,
    description: String,
    isRequired: Bool
  ) -> some View {
    HStack(alignment: .center, spacing: 20) {
      icon
        .renderingMode(.template)
        .background(
          Circle()
            .foregroundStyle(Color.grayscaleLight3)
            .frame(width: 48, height: 48)
        )
      
      VStack(alignment: .leading, spacing: 4) {
        Text(title) +
        Text(isRequired ? " [필수]" : " [선택]")
        Text(description)
          .pretendard(.body_S_M)
          .foregroundStyle(Color.grayscaleDark2)
      }
      .pretendard(.body_M_SB)
      
      Spacer()
    }
    .foregroundStyle(Color.grayscaleBlack)
  }
}

// MARK: - Preview

#Preview("권한 요청 - 카메라 거절 상태") {
  PermissionRequestView(
    viewModel:PermissionRequestViewModel(
      cameraPermissionUseCase: MockCameraPermissionUseCase(isGranted: false),
      photoPermissionUseCase: MockPhotoPermissionUseCase(),
      contactsPermissionUseCase: MockContactsPermissionUseCase(),
      notificationPermissionUseCase: MockNotificationPermissionUseCase()
    )
  )
}

#Preview("권한 요청 - 카메라 허락 상태") {
  PermissionRequestView(
    viewModel: PermissionRequestViewModel(
      cameraPermissionUseCase: MockCameraPermissionUseCase(isGranted: true),
      photoPermissionUseCase: MockPhotoPermissionUseCase(),
      contactsPermissionUseCase: MockContactsPermissionUseCase(),
      notificationPermissionUseCase: MockNotificationPermissionUseCase()
    )
  )
}

class MockCameraPermissionUseCase: CameraPermissionUseCase {
    var isGranted: Bool
    
    init(isGranted: Bool) {
        self.isGranted = isGranted
    }
    
    func execute() async -> Bool {
        return isGranted
    }
}

class MockPhotoPermissionUseCase: PhotoPermissionUseCase {
  func execute() async -> Bool { return true }
}

class MockContactsPermissionUseCase: ContactsPermissionUseCase {
  func execute() async throws -> Bool { return true }
}

class MockNotificationPermissionUseCase: NotificationPermissionUseCase {
  func execute() async throws -> Bool { return true }
}
