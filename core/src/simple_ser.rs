// very simple serializer
// It It can serialize only simple types and it should be enough to satisfy p2p needs

pub struct SimplePushSerializer {
    vec_data: Vec<u8>,
    pub version: u16,
}

impl SimplePushSerializer {
    pub fn new(version: u16) -> Self {
        let mut ser = SimplePushSerializer {
            vec_data: vec![],
            version,
        };
        ser.push_u16(ser.version);
        ser
    }

    pub fn to_vec(self) -> Vec<u8> { self.vec_data }
    pub fn data_len(&self) -> usize {self.vec_data.len()}

    pub fn push_u16(&mut self, data: u16) {
        self.vec_data.push( (data / 256) as u8 );
        self.vec_data.push( (data % 256) as u8 );
    }

    pub fn push_vec(&mut self, data: &[u8]) {
        let sz = data.len();
        debug_assert!(sz<65536);
        self.push_u16(sz as u16);
        self.vec_data.append(&mut data.to_vec());
    }
}

pub struct SimplePopSerializer<'a> {
    vec_data: &'a [u8],
    pub version: u16,
    position: usize,
}

impl<'a> SimplePopSerializer<'a> {
    pub fn new(vec: &'a [u8] ) -> Self {
        let mut ser = SimplePopSerializer {
            vec_data: vec,
            version:0,
            position: 0,
        };
        ser.version = ser.pop_u16();
        ser
    }

    pub fn pop_u16(&mut self) -> u16 {
        if self.position+2 > self.vec_data.len() {
            return 0;
        }
        let res: u16 = (self.vec_data[self.position] as u16) * 256 +
            self.vec_data[self.position+1] as u16;
        self.position += 2;
        res
    }

    pub fn pop_vec(&mut self) -> Vec<u8> {
        let sz = self.pop_u16() as usize;
        if sz==0 || self.position+sz > self.vec_data.len() {
            return vec![];
        }

        let res = self.vec_data[ self.position .. (self.position+sz) ].to_vec();
        self.position += sz;
        res
    }

    pub fn skip_u16(&mut self) {
        self.position += 2;
    }

    pub fn skip_vec(&mut self)  {
        let sz = self.pop_u16() as usize;
        self.position += sz;
    }

}