import datetime # 거래 내역 기록을 위한 datetime 모듈

# [데이터 구조] 계좌 클래스
class Account: # 계좌 클래스는 계좌번호, 은행명, 잔액, 별칭, 거래 내역을 저장하는 구조체. 
    def __init__(self, acc_num, bank, balance, alias):
        self.acc_num = acc_num
        self.bank = bank
        self.balance = balance
        self.alias = alias
        self.history = []  # 거래 내역 저장
        self.add_history(f"개설 입금: {balance}원") #balance로 초기 입금 내역 기록

    def add_history(self, detail): # 거래 내역에 새로운 항목을 추가하는 메서드입니다. detail은 거래의 상세 내용을 문자열로 받습니다.    
        now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') # 현재 날짜와 시간을 "YYYY-MM-DD HH:MM:SS" 형식의 문자열로 생성합니다.      
        self.history.append(f"[{now}] {detail}")

# [데이터 구조] 유저 클래스
class User:
    def __init__(self, uid, upw, name, is_admin=False):
        self.uid = uid
        self.upw = upw
        self.name = name
        self.is_admin = is_admin
        self.accounts = [] # 유저가 소유한 계좌 리스트

# [메인 로직] 시스템 매니저
class BankSystem:
    def __init__(self):
        self.users = {}      # 전체 유저 저장 {id: User객체}
        self.current_user = None # 현재 로그인된 유저

    def run(self):
        while True:
            if not self.current_user:
                print("\n=== 메인 메뉴 ===")
                print("1. 회원가입  2. 로그인  3. 종료")
                menu = input("선택: ")
                if menu == '1': self.register()
                elif menu == '2': self.login()
                elif menu == '3': break
            else:
                self.bank_menu()

    # --- 메인 메뉴 기능 ---
    def register(self):
        uid = input("아이디: ")
        if uid in self.users: return print("이미 존재하는 아이디입니다.")
        upw = input("비밀번호: ")
        name = input("이름: ")
        self.users[uid] = User(uid, upw, name)
        print(f"{name}님, 회원가입을 축하합니다!")

    def login(self):
        uid = input("아이디: ")
        upw = input("비밀번호: ")
        if uid in self.users and self.users[uid].upw == upw:
            self.current_user = self.users[uid]
            print(f"로그인 성공! {self.current_user.name}님 환영합니다.")
        else:
            print("아이디 또는 비밀번호가 틀렸습니다.")

    # --- 은행 메뉴 기능 ---
    def bank_menu(self):
        print(f"\n=== 은행 메뉴 [{self.current_user.name}] ===")
        print("1. 계좌생성  2. 계좌조회  3. 입금  4. 출금  5. 이체  6. 거래내역  7. 로그아웃")
        menu = input("선택: ")

        if menu == '1': self.create_account()
        elif menu == '2': self.show_accounts()
        elif menu == '3': self.deposit()
        elif menu == '7': 
            self.current_user = None
            print("로그아웃 되었습니다.")

    def create_account(self):
        banks = ["하나은행", "우리은행", "국민은행", "신한은행", "기업은행"]
        print(f"가능 은행: {banks}")
        bank = input("은행명: ")
        if bank not in banks: return print("지원하지 않는 은행입니다.")
        
        acc_num = input("계좌번호: ")
        alias = input("계좌 별칭: ")
        money = int(input("최초 입금액(1000원 이상): "))
        
        if money < 1000: return print("1000원 이상 입금해야 생성 가능합니다.")
        
        new_acc = Account(acc_num, bank, money, alias)
        self.current_user.accounts.append(new_acc)
        print(f"[{bank}] 계좌가 생성되었습니다.")   

    def show_accounts(self):
        if not self.current_user.accounts:
            print("보유한 계좌가 없습니다.")
            return
        for i, acc in enumerate(self.current_user.accounts):
            print(f"{i+1}. {acc.bank} | {acc.acc_num} | 별칭: {acc.alias} | 잔액: {acc.balance}원")

    def deposit(self):
        self.show_accounts()
        idx = int(input("입금할 계좌 번호 선택: ")) - 1
        amount = int(input("입금액: "))
        self.current_user.accounts[idx].balance += amount
        self.current_user.accounts[idx].add_history(f"입금: {amount}원")
        print("입금이 완료되었습니다.")

# 시스템 시작
if __name__ == "__main__":
    BankSystem().run()
